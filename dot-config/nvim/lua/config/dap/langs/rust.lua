local dap = require("dap")
local utils = require("utils.dap")

-- 根據 cargo 的 JSON 輸出，解析出真正的可執行檔
local function analyze_compiler_target(input)
	local _, json = pcall(vim.fn.json_decode, input)

	if
		type(json) == "table"
		and json.reason == "compiler-artifact"
		and json.executable ~= nil
		and (vim.tbl_contains(json.target.kind, "bin") or json.profile.test)
	then
		return json.executable
	end
	return nil
end

-- 取得所有可執行檔路徑
-- selection (bins, tests): cargo build --bins, or cargo build --tests
local function list_targets(selection, callback)
	local arg = string.format("--%s", selection or "bins")

	-- cargo build 命令
	local cmd = { "cargo", "build", arg, "--quiet", "--message-format", "json" }

	-- 使用 jobstart 異步執行 cmd
	local stdout_data = {}
	local job_id = vim.fn.jobstart(cmd, {
		-- 接收標準輸出
		on_stdout = function(_, data)
			if data then
				-- 每一行都會是一個描述編譯 artifact 的 JSON
				vim.list_extend(stdout_data, data)
			end
		end,
		on_exit = function(_, code)
			-- 錯誤碼
			if code ~= 0 then
				vim.schedule(function()
					vim.notify("Cargo build failed", vim.log.levels.ERROR)
				end)
				callback(nil)
				return
			end

			local targets = {} -- 紀錄可執行目標
			-- 將每一個 artifact 的 JSON 給 compiler_target 解析
			for _, line in ipairs(stdout_data) do
				if line ~= "" then
					local target = analyze_compiler_target(line)
					if target then
						table.insert(targets, target)
					end
				end
			end

			callback(targets)
		end,
	})

	if job_id <= 0 then
		vim.notify("Failed to start cargo build", vim.log.levels.ERROR)
		callback(nil)
	end
end

local function select_target_async(selection)
	return coroutine.create(function(dap_run_co)
		list_targets(selection, function(targets)
			-- 找不到就跳出 input 手動輸入
			if not targets or #targets == 0 then
				vim.schedule(function()
					local path = utils.read_target()
					coroutine.resume(dap_run_co, path)
				end)
				return
			end

			if #targets == 1 then
				coroutine.resume(dap_run_co, targets[1])
				return
			end

			-- 若有多個 binaries 跳出選單
			vim.schedule(function()
				local opts = {
					prompt = "Select target executable:",
					format_item = function(path)
						local parts = vim.split(path, utils.get_sep(), { trimempty = true })
						return parts[#parts]
					end,
				}

				vim.ui.select(targets, opts, function(choice)
					if choice then
						coroutine.resume(dap_run_co, choice)
					else
						return
					end
				end)
			end)
		end)
	end)
end

-- 從當前行找出 #[test] 函數名稱，用於單獨測試 debug
local function select_test()
	local line = vim.api.nvim_get_current_line()
	local test_match = string.match(line, "fn%s+([%w_]+).*#%[test%]")
	return test_match
end

local default = {
	type = "codelldb",
	request = "launch",
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	program = function()
		return select_target_async("bins")
	end,
	env = function()
		local variables = {}
		local path_var = (vim.fn.has("win32") == 1) and "PATH"
			or (vim.fn.has("mac") == 1) and "DYLD_LIBRARY_PATH"
			or "LD_LIBRARY_PATH"

		local rust_lib_path = vim.fn.trim(vim.fn.system("rustc --print target-libdir"))
		if rust_lib_path == "" then
			vim.notify("Failed to retrieve Rust library path", vim.log.levels.ERROR)
			return nil
		end
		local target_path = vim.fn.getcwd() .. "/target/debug/deps"

		-- prepend rust path into $PATH
		variables[path_var] = rust_lib_path .. ":" .. target_path
		return variables
	end,
	-- This allows the debugger to locate and display Rust standard library source code
	sourceMap = { ["/rustc/*"] = vim.fn.expand("$RUST_SRC_PATH") },
	-- Because lldb is primarily designed for C/C++ debugging, it may not be able to interpret Rust types and data structures correctly.
	initCommands = function()
		-- Get the commands from the Rust installation
		local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))
		if rustc_sysroot == "" then
			vim.notify("Failed to retrieve Rust sysroot", vim.log.levels.ERROR)
			return {}
		end
		-- script provides custom logic to interpret and display Rust types and data structures correctly
		local script = rustc_sysroot .. "/lib/rustlib/etc/lldb_lookup.py"
		-- contains a set of predefined LLDB commands
		local commands_file = rustc_sysroot .. "/lib/rustlib/etc/lldb_commands"

		local cmds = { 'command script import "' .. script .. '"' }
		local file = io.open(commands_file, "r")
		if file then
			for line in file:lines() do
				table.insert(cmds, line)
			end
			file:close()
		end

		return cmds
	end,
}

dap.configurations.rust = {
	vim.tbl_extend("force", default, { name = "Debug" }),
	vim.tbl_extend("force", default, { name = "Debug (+args)", args = utils.read_args }),

	vim.tbl_extend("force", default, {
		name = "Debug tests",
		program = function()
			return select_target_async("tests")
		end,
		args = { "--test-threads=1" },
	}),
	vim.tbl_extend("force", default, {
		name = "Debug tests (+args)",
		program = function()
			return select_target_async("tests")
		end,
		args = function()
			return vim.list_extend(utils.read_args(), { "--test-threads=1" })
		end,
	}),
	vim.tbl_extend("force", default, {
		name = "Debug test (cursor)",
		program = function()
			return select_target_async("tests")
		end,
		args = function()
			local test = select_test()
			local args = test and { "--exact", test } or {}
			return vim.list_extend(args, { "--test-threads=1" })
		end,
	}),
	vim.tbl_extend("force", default, { name = "Attach debugger", request = "attach", program = select_target_async }),
}

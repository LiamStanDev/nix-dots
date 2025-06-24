local dap = require("dap")
local utils = require("utils.dap")

--- Parses the JSON output from Cargo to extract the executable path.
-- @param input The JSON string output from Cargo.
-- @return The path to the executable if found, otherwise nil.
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

--- Extracts and returns compiler error messages from Cargo JSON output.
-- @param input The JSON string output from Cargo.
-- @return The rendered error message if found, otherwise nil.
local function compiler_error(input)
	local _, json = pcall(vim.fn.json_decode, input)

	if type(json) == "table" and json.reason == "compiler-message" then
		return json.message.rendered
	end

	return nil
end

--- Lists all executable targets (binaries or tests) by running Cargo build.
-- @param selection The type of targets to list ("bins" or "tests").
-- @return A list of executable paths or nil if an error occurs.
local function list_targets(selection)
	local arg = string.format("--%s", selection or "bins")

	-- Cargo build command
	local cmd = { "cargo", "build", arg, "--quiet", "--message-format", "json" }

	local out = vim.fn.systemlist(cmd)

	if vim.v.shell_error ~= 0 then
		local errors = vim.tbl_map(compiler_error, out)
		vim.notify(table.concat(errors, "\n"), vim.log.levels.ERROR)
		return nil
	end

	local function filter(e)
		return e ~= nil
	end

	return vim.tbl_filter(filter, vim.tbl_map(analyze_compiler_target, out))
end

--- Synchronously selects a target executable.
-- @param selection The type of targets to list ("bins" or "tests").
-- @return The selected target path or nil if no target is selected.
local function select_target(selection)
	local targets = list_targets(selection)

	if targets == nil then
		return nil
	end

	if #targets == 0 then
		return utils.read_target()
	end

	if #targets == 1 then
		return targets[1]
	end

	-- If multiple targets are found, show a selection menu.
	local opts = {
		prompt = "Select a target:",
		format_item = function(path)
			local parts = vim.split(path, utils.get_sep(), { trimempty = true })
			return parts[#parts]
		end,
	}

	return require("utils.picker").select_sync(targets, opts)
end

--- Extracts the test function name from the current line.
-- @return The test function name if found, otherwise nil.
local function select_test()
	local line = vim.api.nvim_get_current_line()
	local test_match = string.match(line, "fn%s+([%w_]+).*#%[test%]")
	return test_match
end

-- Default DAP configuration for Rust debugging.
local default = {
	type = "codelldb",
	request = "launch",
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
	program = function()
		return select_target("bins")
	end,
	env = function()
		local variables = {}
		local path_var = (vim.fn.has("mac") == 1) and "DYLD_LIBRARY_PATH" or "LD_LIBRARY_PATH"

		local rust_lib_path = vim.fn.trim(vim.fn.system("rustc --print target-libdir"))
		if rust_lib_path == "" then
			vim.notify("Failed to retrieve Rust library path", vim.log.levels.ERROR)
			return nil
		end
		local target_path = vim.fn.getcwd() .. "/target/debug/deps"

		-- Prepend Rust path into $PATH.
		variables[path_var] = rust_lib_path .. ":" .. target_path
		return variables
	end,
	-- This allows the debugger to locate and display Rust standard library source code.
	sourceMap = { ["/rustc/*"] = vim.fn.expand("$RUST_SRC_PATH") },
	-- Initializes LLDB with Rust-specific commands for better debugging.
	initCommands = function()
		-- Get the commands from the Rust installation.
		local rustc_sysroot = vim.fn.trim(vim.fn.system("rustc --print sysroot"))
		if rustc_sysroot == "" then
			vim.notify("Failed to retrieve Rust sysroot", vim.log.levels.ERROR)
			return {}
		end
		-- Script provides custom logic to interpret and display Rust types and data structures correctly.
		local script = rustc_sysroot .. "/lib/rustlib/etc/lldb_lookup.py"
		-- Contains a set of predefined LLDB commands.
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

-- DAP configurations for Rust debugging.
dap.configurations.rust = {
	vim.tbl_extend("force", default, { name = "Debug" }),
	vim.tbl_extend("force", default, { name = "Debug (+args)", args = utils.read_args }),

	vim.tbl_extend("force", default, {
		name = "Debug tests",
		program = function()
			return select_target("tests")
		end,
		args = { "--test-threads=1" },
	}),
	vim.tbl_extend("force", default, {
		name = "Debug tests (+args)",
		program = function()
			return select_target("tests")
		end,
		args = function()
			return vim.list_extend(utils.read_args(), { "--test-threads=1" })
		end,
	}),
	vim.tbl_extend("force", default, {
		name = "Debug test (cursor)",
		program = function()
			return select_target("tests")
		end,
		args = function()
			local test = select_test()
			local args = test and { "--exact", test } or {}
			return vim.list_extend(args, { "--test-threads=1" })
		end,
	}),
	vim.tbl_extend("force", default, { name = "Attach debugger", request = "attach", program = select_target }),
}

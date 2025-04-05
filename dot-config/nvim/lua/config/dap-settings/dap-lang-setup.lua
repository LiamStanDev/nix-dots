local dap = require("dap")
local utils = require("utils.dap")

dap.configurations.rust = {
	{
		name = "Rust Debug",
		type = "codelldb",
		request = "launch",
		program = utils.get_rust_bin,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
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
	},
}

dap.configurations.c = {
	{
		name = "LLDB: Launch",
		type = "codelldb",
		request = "launch",
		program = utils.get_file,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
}

dap.configurations.cpp = {
	{
		name = "LLDB: Launch",
		type = "codelldb",
		request = "launch",
		program = utils.get_file,
		cwd = "${workspaceFolder}",
		stopOnEntry = false,
		args = {},
	},
	{
		name = "Launch",
		type = "gdb",
		request = "launch",
		program = function()
			return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
		end,
		cwd = "${workspaceFolder}",
		stopAtBeginningOfMainSubprogram = false,
	},
}

dap.configurations.cs = {
	{
		name = "NetCoreDbg: Launch",
		type = "coreclr",
		mode = "local",
		request = "launch",
		cwd = "${fileDirname}",
		program = utils.get_cs_dll,
	},
	-- https://stackoverflow.com/questions/77013544/error-on-attach-key-processid-not-found-when-trying-attach-neovim-dap-debu
	{
		name = "NetCoreDbg: Attach (Local)",
		type = "coreclr",
		mode = "local",
		request = "attach",
		cwd = "${fileDirname}",
		processId = require("dap.utils").pick_process,
	},
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
	{
		type = "delve",
		name = "Debug",
		request = "launch",
		program = "${file}",
	},
	{
		type = "delve",
		name = "Debug test", -- configuration for debugging test files
		request = "launch",
		mode = "test",
		program = "${file}",
	},
	-- works with go.mod packages and sub packages
	{
		type = "delve",
		name = "Debug test (go.mod)",
		request = "launch",
		mode = "test",
		program = "./${relativeFileDirname}",
	},
}

-- local venv_path = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
-- dap.configurations.python = {
-- 	{
-- 		name = "Python: Launch",
-- 		type = "python",
-- 		request = "launch",
-- 		program = "${file}",
-- 		pythonPath = venv_path and (venv_path .. "/bin/python") or nil,
-- 	},
-- }

dap.configurations.python = {
	{
		-- The first three options are required by nvim-dap
		type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
		request = "launch",
		name = "Launch file",

		-- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

		program = "${file}", -- This configuration will launch the current file if used.
		-- pythonPath = function()
		-- 	-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
		-- 	-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
		-- 	-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
		-- 	local cwd = vim.fn.getcwd()
		-- 	local venv_path = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
		-- 	if vim.fn.executable(venv_path .. "/bin") == 1 then
		-- 		return venv_path .. "/bin"
		-- 	elseif vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
		-- 		return cwd .. "/venv/bin/python"
		-- 	elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
		-- 		return cwd .. "/.venv/bin/python"
		-- 	else
		-- 		return "/usr/bin/python"
		-- 	end
		-- end,
	},
}

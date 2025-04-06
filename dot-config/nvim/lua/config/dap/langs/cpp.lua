local dap = require("dap")
local utils = require("utils.dap")

local default = {
	type = "codelldb",
	request = "launch",
	program = utils.read_target,
	cwd = "${workspaceFolder}",
	stopOnEntry = false,
}

dap.configurations.c = {
	vim.tbl_extend("force", default, { name = "Debug" }),
	vim.tbl_extend("force", default, { name = "Debug (+args)", args = utils.read_args }),
}

dap.configurations.cpp = {
	vim.tbl_extend("force", default, { name = "Debug" }),
	vim.tbl_extend("force", default, { name = "Debug (+args)", args = utils.read_args }),
}

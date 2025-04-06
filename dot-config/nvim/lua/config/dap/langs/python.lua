local dap = require("dap")
local utils = require("utils.dap")

dap.configurations.python = {
	{
		name = "Debug file",
		type = "debugpy",
		request = "launch",
		program = "${file}",
	},
	{
		name = "Debug file (+args)",
		type = "debugpy",
		request = "launch",
		program = "${file}",
		args = utils.read_args,
	},
}

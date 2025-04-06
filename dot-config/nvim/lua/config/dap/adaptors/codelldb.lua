local dap = require("dap")
local utils = require("utils.dap")

-- rust/c/c++: codelldb configs
dap.adapters.codelldb = {
	type = "server",
	port = "${port}",
	executable = {
		command = utils.get_mason_adaptor_path() .. "codelldb",
		args = { "--port", "${port}" },
	},
}

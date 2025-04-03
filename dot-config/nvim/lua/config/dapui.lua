return function()
	local dapui = require("dapui")


	dapui.setup({
		icons = { expanded = "", collapsed = "", circular = "" },
		layouts = {
			{
				elements = {
					{
						id = "repl",
						size = 0.3,
					},
					{
						id = "breapoints",
						size = 0.2,
					},
					{
						id = "stacks",
						size = 0.3,
					},
					{
						id = "console",
						size = 0.2,
					},
				},
				position = "right",
				size = 50,
			},
			{
				elements = {
					{
						id = "scopes",
						size = 0.5,
					},
					{
						id = "watches",
						size = 0.5,
					},
				},
				position = "bottom",
				size = 20,
			},
		},
	})

	-- for auto open and close
	local dap = require("dap")
	dap.listeners.after.event_initialized["dapui_config"] = dapui.open
	dap.listeners.before.event_terminated["dapui_config"] = dapui.close
	dap.listeners.before.event_exited["dapui_config"] = dapui.close
end

return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			{ "theHamsta/nvim-dap-virtual-text", config = true },
			{
				"rcarriga/nvim-dap-ui",
				config = require("config.dapui"),
				dependencies = {
					"nvim-neotest/nvim-nio",
					{
						"folke/neodev.nvim",
						enabled = false, -- conflict with lazydev
					},
				},
			},
		},
		init = require("config.dap").init,
		config = require("config.dap").config,
	},
}

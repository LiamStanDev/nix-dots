return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			{ "theHamsta/nvim-dap-virtual-text", config = true },
			{
				"rcarriga/nvim-dap-ui",
				config = require("settings.dapui"),
				dependencies = { "nvim-neotest/nvim-nio", "folke/neodev.nvim" },
			},
		},
		init = require("settings.dap").init,
		config = require("settings.dap").config,
	},
}

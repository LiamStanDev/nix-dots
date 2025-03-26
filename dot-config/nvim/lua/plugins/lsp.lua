local config = require("core.globals")

return {
	-- Services installer
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		config = function()
			require("mason").setup({
				PATH = "prepend", -- not working when nix "prepend", "append","skip"
				pip = {
					upgrade_pip = true,
				},
				max_concurrent_installers = 10,
			})
		end,
		dependencies = {
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				config = function()
					local service_identifiers = require("utils.lsp").get_service_identifiers(config)
					require("mason-tool-installer").setup({
						ensure_installed = service_identifiers,
					})
				end,
			},
		},
	},

	-- LSP plugins
	{ -- LSP for neovim configuration
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ -- Main LSP configuration
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{
				"glepnir/lspsaga.nvim",
				event = "LspAttach",
				dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
				opts = require("settings.lspsaga"),
			},
		},
		config = require("settings.lspconfig"),
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ async = true, lsp_format = "fallback" })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			notify_on_error = false,
			formatters_by_ft = require("core.globals").formatter_services,
		},
	},
	{ -- Autolint
		"mfussenegger/nvim-lint",
		config = function()
			require("lint").linters_by_ft = config.linting_services
			vim.api.nvim_create_autocmd({ "BufWritePost" }, {
				callback = function()
					require("lint").try_lint()
				end,
			})
		end,
	},
}

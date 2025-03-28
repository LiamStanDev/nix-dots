local config = require("core.globals")

return {
	-- Hightlight
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				additional_vim_regex_highlighting = false, -- true will slow down editor.
				indent = { enable = true }, -- can use `=` operator
				ensure_installed = config.code_hight_servers,
				auto_install = true,
			})
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-context", -- pin function signature on top
			event = { "BufReadPost", "BufNewFile" },
			opts = {
				-- I just want to show the function signature
				max_lines = 4, -- =0 means no limit
				trim_scope = "inner",
			},
		},
	},

	-- Autopairs
	{ "windwp/nvim-autopairs", event = "InsertEnter", opts = require("settings.autopairs") },

	-- Comment
	{
		"numToStr/Comment.nvim",
		event = "InsertEnter",
		config = function()
			require("Comment").setup()
		end,
	},

	-- Completion Engine
	{
		"hrsh7th/nvim-cmp",
		event = "InsertEnter",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-cmdline",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"saadparwaiz1/cmp_luasnip",
			"rcarriga/cmp-dap",
			"onsails/lspkind.nvim",
			"teramako/cmp-cmdline-prompt.nvim",
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",
				config = require("settings.luasnippet"),
			},
			{
				"zbirenbaum/copilot-cmp",
				config = true,
			},
		},
		config = require("settings.nvim-cmp").config,
	},

	-- input and select ui
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			bigfile = { enabled = true },
			dashboard = require("settings.snacks.dashboard"),
			explorer = { enabled = true },
			indent = { enabled = true },
			input = { enabled = true },
			picker = require("settings.snacks.picker"),
			notifier = require("settings.snacks.notifier"),
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = true },
			words = { enabled = false },
			terminal = require("settings.snacks.terminal"),
			lazygit = require("settings.snacks.lazygit"),
		},
		dependencies = {},
	},

	-- Neovim notifications, LSP progress messages and input ui
	{
		"folke/noice.nvim", -- for command line pop window and nottify
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
		},
		config = require("settings.noice"),
	},

	-- Keymap hint
	{
		"folke/which-key.nvim",
		event = "VimEnter", -- Sets the loading event to 'VimEnter'
		opts = {
			delay = 300,
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "  ", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group,
				mappings = false,
			},
			win = { border = config.which_key_window_border },
			keys = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},

			disable = {
				buftypes = {},
				filetypes = { "TelescopePrompt" },
			},

			-- Document existing key chains
			spec = {
				{ "<leader>s", group = "Search" },
				{ "<leader>a", group = "AI" },
				{ "<leader>b", group = "Buffer" },
				{ "<leader>g", group = "Git", mode = { "n", "v" } },
				{ "<leader>d", group = "Debug", mode = "n" },
			},
		},
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = require("settings.gitsigns"),
	},

	-- Telescope [replace by snacks.nvim picker]
	-- {
	-- 	"nvim-telescope/telescope.nvim",
	-- 	event = "VimEnter",
	-- 	branch = "0.1.x",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"nvim-tree/nvim-web-devicons",
	-- 		{
	-- 			"nvim-telescope/telescope-fzf-native.nvim",
	-- 			build = "make",
	-- 			cond = function()
	-- 				return vim.fn.executable("make") == 1
	-- 			end,
	-- 		},
	-- 		{
	-- 			"tomasky/bookmarks.nvim",
	-- 			config = true,
	-- 		},
	-- 	},
	-- 	config = require("settings.telescope"),
	-- },

	-- Column segments (ufo, dap, gitsign) [replace by snacks.nvim]
	-- {
	-- 	"luukvbaal/statuscol.nvim",
	-- 	config = function()
	-- 		local builtin = require("statuscol.builtin")
	-- 		require("statuscol").setup({
	-- 			relculright = true,
	-- 			segments = {
	-- 				{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
	-- 				{ text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
	-- 				{ text = { "%s" }, click = "v:lua.ScSa" },
	-- 			},
	-- 		})
	-- 	end,
	-- },

	-- Markdown
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			file_types = { "markdown", "copilot-chat" },
			render_modes = true,
		},
	},

	-- Dashboard [replace by snack.nvim]
	-- {
	-- 	"goolord/alpha-nvim",
	-- 	dependencies = { "echasnovski/mini.icons" },
	-- 	config = require("settings.alpha"),
	-- },

	-- File explorer
	{ "echasnovski/mini.files", version = false, config = require("settings.mini-files") },

	-- Status line
	{ "nvim-lualine/lualine.nvim", event = "VeryLazy", config = require("settings.lualine") },

	-- Terminal [replace by snacks.nvim]
	-- { "akinsho/toggleterm.nvim", version = "*", config = require("settings.toggleterm") },

	-- Copilot
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "zbirenbaum/copilot.lua", event = "InsertEnter", config = true },
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		branch = "main",
		build = "make tiktoken", -- Only on MacOS or Linux
		config = require("settings.copilot-chat"),
	},

	-- Indent [replace by snackes.nvim]
	-- {
	-- 	"lukas-reineke/indent-blankline.nvim",
	-- 	main = "ibl",
	-- 	event = { "BufReadPost", "BufNewFile" },
	-- 	config = function()
	-- 		require("ibl").setup({
	-- 			indent = { char = "▎" },
	-- 			scope = {
	-- 				enabled = false,
	-- 				show_exact_scope = true,
	-- 				highlight = { "IBLScope" },
	-- 			},
	-- 		})
	-- 	end,
	-- },
	-- {
	-- 	"echasnovski/mini.indentscope",
	-- 	version = "*",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	init = require("settings.indentscope").init,
	-- 	config = require("settings.indentscope").config,
	-- },

	--  Code folding
	{
		"kevinhwang91/nvim-ufo",
		init = function()
			vim.o.foldcolumn = "1" -- '0' is not bad
			vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
			vim.o.foldlevelstart = 99
			vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
			vim.o.foldenable = true
		end,

		config = function()
			require("ufo").setup({
				provider_selector = function()
					return { "treesitter", "indent" }
				end,
			})
			local map = vim.keymap.set
			map("n", "zR", require("ufo").openAllFolds, { desc = "Open all folds" })
			map("n", "zM", require("ufo").closeAllFolds, { desc = "Close all folds" })
		end,
		event = { "BufReadPost" },
		dependencies = {
			"kevinhwang91/promise-async",
		},
	},

	{
		-- sa: surround add
		-- sd: surround delete
		-- sr: surround replace
		"echasnovski/mini.surround",
		version = "*",
		config = true,
	},

	-- Todo
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = require("settings.todo-comment"),
		-- config = true,
	},

	-- Text Color
	{
		"NvChad/nvim-colorizer.lua", -- integrated with tailwind
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("colorizer").setup()
		end,
	},

	-- Fast movement
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
        -- stylua: ignore
        keys = {
            { "S", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" }
        },
	},

	-- beautiful diagnostic
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "LspAttach", -- Or `LspAttach`
		priority = 1000, -- needs to be loaded in first
		config = function()
			require("tiny-inline-diagnostic").setup({

				preset = "ghost",
				multilines = true,
				break_line = {
					enabled = true,
				},
			})
			vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
		end,
	},

	-- quit bad vim habit
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	},
}

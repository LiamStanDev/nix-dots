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

	{
		"saghen/blink.cmp",
		version = "1.*",
		config = require("settings.blink-cmp"),
		opts_extend = { "sources.default" },
		dependencies = {
			{
				"xzbdmw/colorful-menu.nvim",
				config = true,
			},
			"fang2hou/blink-copilot",
		},
	},
	{
		"folke/trouble.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		cmd = { "Trouble", "TroubleToggle" },
		opts = {},
        --stylua: ignore
		keys = {
			{ "<leader>st", "<CMD>Trouble todo toggle<CR>" },
		},
	},

	-- input and select ui
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = require("settings.snacks.dashboard"),
			explorer = { enabled = false },
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
			styles = {
				notification = {
					wo = {
						wrap = true,
					},
				},
				input = {
					relative = "cursor",
					width = 30,
				},
			},
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
				-- { "<leader>b", group = "Buffer" },
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

	-- Markdown
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
		opts = {
			file_types = { "markdown", "copilot-chat" },
			render_modes = true,
		},
	},

	-- File explorer
	-- { "echasnovski/mini.files", version = false, config = require("settings.mini-files") },
	{
		"mikavilpas/yazi.nvim",
		event = "VeryLazy",
		dependencies = { "folke/snacks.nvim", lazy = true },
		keys = {
			{
				"<leader>e",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
		},
		---@type YaziConfig | {}
		opts = {
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
				open_file_in_vertical_split = "<c-v>",
				open_file_in_horizontal_split = "<c-x>",
				-- open_file_in_tab = "<c-t>",
				-- grep_in_directory = "<c-s>",
				-- replace_in_directory = "<c-g>",
				-- cycle_open_buffers = "<tab>",
				-- copy_relative_path_to_selected_files = "<c-y>",
				send_to_quickfix_list = "<c-q>",
				change_working_directory = "<c-\\>",
			},
		},
		init = function()
			vim.g.loaded_netrwPlugin = 1
		end,
	},

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		config = require("settings.lualine"),
	},

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

	--  Code folding
	{
		"kevinhwang91/nvim-ufo",

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

	-- quit bad vim habit
	{
		"m4xshen/hardtime.nvim",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {},
	},
}

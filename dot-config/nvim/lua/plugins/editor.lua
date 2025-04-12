local G = require("core")

return {
	-- Hightlight
	{
		"nvim-treesitter/nvim-treesitter",
		version = false, -- last release
		build = ":TSUpdate",
		event = { "VeryLazy" },
		cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
		keys = {
			{ "<c-space>", desc = "Increment Selection" },
			{ "<bs>", desc = "Decrement Selection", mode = "x" },
		},
		init = function()
			require("nvim-treesitter.query_predicates")
		end,
		opts = {
			highlight = { enable = true },
			additional_vim_regex_highlighting = false, -- true will slow down editor.
			indent = { enable = true }, -- can use `=` operator
			ensure_installed = G.code_hl_servers,
			auto_install = true,
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<A-i>",
					node_incremental = "<A-i>",
					scope_incremental = false,
					node_decremental = "<A-d>",
				},
			},
			textobjects = {
				move = {
					enable = true,
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
						["]a"] = "@parameter.inner",
					},
					goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
						["[a"] = "@parameter.inner",
					},
					goto_previous_end = {
						["[F"] = "@function.outer",
						["[C"] = "@class.outer",
						["[A"] = "@parameter.inner",
					},
				},
			},
		},
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			{
				"nvim-treesitter/nvim-treesitter-context", -- pin function signature on top
				event = { "BufReadPost", "BufNewFile" },
				opts = {
					-- I just want to show the function signature
					max_lines = 4, -- =0 means no limit
					trim_scope = "inner",
				},
			},
		},
	},

	{
		"echasnovski/mini.pairs",
		event = "VeryLazy",
		version = "*",
		opts = {
			modes = { insert = true, command = true, terminal = false },
			-- skip autopair when next character is one of these
			skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
			-- skip autopair when the cursor is inside these treesitter nodes
			skip_ts = { "string" },
			-- skip autopair when next character is closing pair
			-- and there are more closing pairs than opening pairs
			skip_unbalanced = true,
			-- better deal with markdown code blocks
			markdown = true,
		},
		config = function(_, opts)
			require("utils.mini").pair(opts)
		end,
	},

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
		config = require("config.blink-cmp"),
		opts_extend = { "sources.default" },
		dependencies = {
			{
				-- nvim-cmp compatibility layer
				"saghen/blink.compat",
				version = "*",
				lazy = true,
				opts = {},
			},
			{
				"xzbdmw/colorful-menu.nvim",
				config = true,
			},
			"kristijanhusak/vim-dadbod-completion",
			"fang2hou/blink-copilot",
			"rcarriga/cmp-dap",
		},
	},

	{
		"folke/trouble.nvim",
		opts = {
			warn_no_results = false,
			open_no_results = true,
			focus = true,
			win = {
				position = "left",
			},
			preview = {
				type = "float",
				relative = "editor",
				border = "rounded",
				title = "Preview",
				title_pos = "center",
				position = { 0, -2 },
				size = { width = 0.3, height = 0.3 },
				zindex = 200,
			},
		},
		cmd = "Trouble",
		keys = {},
	},

	-- input and select ui
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			bigfile = { enabled = true },
			dashboard = require("config.snacks.dashboard"),
			explorer = { enabled = false },
			indent = { enabled = true },
			input = { enabled = true },
			picker = require("config.snacks.picker"),
			notifier = require("config.snacks.notifier"),
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = false },
			statuscolumn = { enabled = true },
			words = { enabled = false },
			terminal = require("config.snacks.terminal"),
			lazygit = require("config.snacks.lazygit"),
			styles = {
				notification = {
					wo = {
						wrap = true, -- see all message inside window
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
		config = require("config.noice"),
	},

	-- Keymap hint
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "helix",
			-- delay = 300,
			icons = {
				breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
				separator = "  ", -- symbol used between a key and it's label
				group = "+", -- symbol prepended to a group,
				mappings = false,
			},
			win = { border = G.which_key_window_border },
			keys = {
				scroll_down = "<c-d>", -- binding to scroll down inside the popup
				scroll_up = "<c-u>", -- binding to scroll up inside the popup
			},

			disable = {
				ft = { "terminal", "snacks_terminal", "snacks_picker_input", "snacks_picker_list" },
				bt = {},
			},

			-- Document existing key chains
			spec = {
				{
					mode = { "n", "v" },
					{ "<leader>s", group = "Search" },
					{ "<leader>a", group = "AI" },
					{ "<leader>g", group = "Git", mode = { "n", "v" } },
					{ "<leader>gh", group = "Git Hunk" },
					{ "<leader>gr", group = "Lsp" },
					{ "<leader>gs", group = "Surround" },
					{ "<leader>u", group = "Management" },
					{ "<leader>ul", "<CMD>Lazy<CR>", desc = "Lazy" },
					{ "<leader>d", group = "Debug", mode = "n" },
					{ "[", group = "prev" },
					{ "]", group = "next" },
					{ "g", group = "goto" },
					{ "gs", group = "surround" },
					{ "z", group = "fold" },
					{
						"<leader>b",
						group = "Buffer",
						expand = function()
							return require("which-key.extras").expand.buf()
						end,
					},
					{
						"<leader>w",
						group = "Windows",
						proxy = "<c-w>",
						expand = function()
							return require("which-key.extras").expand.win()
						end,
					},
				},
			},
		},
	},

	-- Git
	{
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		config = require("config.gitsigns"),
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
		config = require("config.lualine.init"),
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
		config = require("config.copilot-chat"),
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
		end,
		keys = {
			{
				"zR",
				mode = "n",
				function()
					require("ufo").openAllFolds()
				end,
				desc = "Open all folds",
			},
			{
				"zM",
				mode = "n",
				function()
					require("ufo").closeAllFolds()
				end,
				desc = "Close all folds",
			},
		},
		event = { "BufReadPost" },
		dependencies = {
			"kevinhwang91/promise-async",
		},
	},

	{
		"echasnovski/mini.surround",
		version = "*",
		opts = {
			mappings = {
				add = "gsa", -- Add surrounding in Normal and Visual modes
				delete = "gsd", -- Delete surrounding
				find = "gsf", -- Find surrounding (to the right)
				find_left = "gsF", -- Find surrounding (to the left)
				highlight = "gsh", -- Highlight surrounding
				replace = "gsr", -- Replace surrounding
				update_n_lines = "gsn", -- Update `n_lines`
			},
		},
	},

	-- Todo
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = require("config.todo-comment"),
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
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			enabled = G.quit_bad_habit,
			max_count = 4,
			disable_mouse = false,
		},
	},

	{
		"otavioschwanck/arrow.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
		},
		opts = {
			show_icons = true,
			leader_key = ";", -- Recommended to be a single key
			buffer_leader_key = "m", -- Per Buffer Mappings
		},
	},

	-- {
	-- 	"folke/edgy.nvim",
	-- 	event = "VeryLazy",
	-- 	opts = require("config.edgy"),
	-- 	keys = {
	-- 		{
	-- 			"<leader>ue",
	-- 			function()
	-- 				require("edgy").toggle()
	-- 			end,
	-- 			desc = "Edgy Toggle",
	-- 		},
	--    -- stylua: ignore
	--    { "<leader>uE", function() require("edgy").select() end, desc = "Edgy Select Window" },
	-- 	},
	-- },
}

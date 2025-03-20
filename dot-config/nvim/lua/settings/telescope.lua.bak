return function()
	local telescope = require("telescope")
	local actions = require("telescope.actions")

	telescope.setup({
		defaults = {
			mappings = {
				-- ctrl + v will open in vsplit
				i = {
					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,
					["<C-v>"] = actions.file_vsplit,
					["<C-s>"] = actions.file_split,
				},
				n = { ["q"] = require("telescope.actions").close },
			},
			vimgrep_arguments = {
				"rg",
				"-L", -- follow symbolic links
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				-- "--hidden",
				"--glob=!.git/",
			},
			file_ignore_patterns = {
				".git/",
				"build/",
				".cache",
				"%.o",
				"%.a",
				"%.out",
				"%.class",
				-- "%.pdf",
				"%.mkv",
				"%.mp4",
				"%.zip",
			},
			prompt_prefix = "   ",
			selection_caret = "  ",
			entry_prefix = "  ",
			initial_mode = "insert",
			winblend = 0, -- transparency
			path_display = { "truncate" },
			color_devicons = true,
			selection_strategy = "reset",
			sorting_strategy = "ascending",
			layout_strategy = "horizontal",
			layout_config = {
				horizontal = {
					prompt_position = "bottom",
					preview_width = 0.55,
					results_width = 0.8,
				},
				vertical = {
					mirror = false,
				},
				width = 0.87,
				height = 0.80,
				preview_cutoff = 120,
			},
		},
		pickers = {
			find_files = {
				hidden = true,
			},
			live_grep = {
				only_sort_text = true,
			},
			grep_string = {
				only_sort_text = true,
			},
			planets = {
				show_pluto = true,
				show_moon = true,
			},
			git_files = {
				hidden = true,
				show_untracked = true,
			},
			colorscheme = {
				enable_preview = true,
			},
		},
		extensions = {
			["ui-select"] = {
				require("telescope.themes").get_dropdown(),
			},
		},
	})

	-- Extension should load after setup
	-- telescope.load_extension("ui-select")
	telescope.load_extension("fzf")
	telescope.load_extension("bookmarks")

	local builtin = require("telescope.builtin")
	vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
	vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })
	vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
	vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Select Telescope" })
	vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
	vim.keymap.set("n", "<leader>st", builtin.live_grep, { desc = "Search by Grep" })
	vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
	-- vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Resume Search" })
	vim.keymap.set("n", "<leader>sm", "<CMD>Telescope bookmarks list<CR>", { desc = "Search Bookmark" })
	vim.keymap.set("n", "<leader>p", function()
		require("telescope.builtin").find_files(
			require("telescope.themes").get_dropdown({ previewer = false, hidden = true })
		)
	end, { desc = "Find file" })

	local themes = require("telescope.themes")

	vim.api.nvim_create_user_command("ShowTasks", function()
		require("utils.task").open_task_menu(themes.get_dropdown({}))
	end, { nargs = 0 })

	local keymap = vim.keymap.set
	-- task runner
	keymap({ "n", "i", "v", "t" }, "<A-\\>", "<CMD>ShowTasks<CR>")
end

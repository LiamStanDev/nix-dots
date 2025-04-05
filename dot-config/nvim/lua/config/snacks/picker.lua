local G = require("core")
local utils = require("utils.picker")

vim.api.nvim_create_user_command("ShowTasks", function()
	utils.open_task_menu()
end, { nargs = 0 })

-- NOTE: layout has following options: vertical, ivy, ivy_split,
-- dropdown, select, default, sidebar, vscode.

local mappings = {
	-- Explorer
	{
		mode = "n",
		key = "<leader>e",
		action = function()
			Snacks.picker.explorer({ hidden = true, ignored = true })
		end,
		desc = "Explorer",
	},

	-- Task Runner
	{ mode = { "n", "i", "v", "t" }, key = "<A-]>", action = "<CMD>ShowTasks<CR>" },

	-- Git
	{
		mode = "n",
		key = "<leader>gb",
		action = function()
			Snacks.picker.git_branches({ layout = "select" })
		end,
		desc = "Git Branches",
	},
	{
		mode = "n",
		key = "<leader>gl",
		action = function()
			Snacks.picker.git_log({
				finder = "git_log",
				format = "git_log",
				preview = "git_show",
				checkout = "git_checkout",
				layout = "vertical",
			})
		end,
		desc = "Git Log",
	},
	{
		mode = "n",
		key = "<leader>gS",
		action = function()
			Snacks.picker.git_stash()
		end,
		desc = "Git Stash",
	},

	-- Search
	{
		mode = "n",
		key = "<leader>p",
		action = function()
			Snacks.picker.files({
				finder = "files",
				format = "file",
				show_empty = true,
				support_live = true,
				hidden = true,
				layout = "select",
				follow = true,
				exclude = G.exclude_pattern,
			})
		end,
		desc = "Smart Find Files",
	},
	{
		mode = "n",
		key = "<leader>sb",
		action = function()
			Snacks.picker.buffers({
				on_show = function()
					vim.cmd.stopinsert()
				end,
				finder = "buffers",
				format = "buffer",
				hidden = false,
				unloaded = true,
				current = true,
				sort_lastused = true,
				win = {
					input = { keys = { ["d"] = "bufdelete" } },
					list = { keys = { ["d"] = "bufdelete" } },
				},
				layout = "ivy",
			})
		end,
		desc = "Buffers",
	},
	{
		mode = "n",
		key = "<leader>sg",
		action = function()
			Snacks.picker.grep({
				hidden = true,
				regex = true,
				live = true,
				dirs = { vim.fn.getcwd() },
				args = { "--no-ignore" },
				finder = "grep",
				format = "file",
				show_empty = true,
				layout = "ivy",
				follow = true,
				exclude = G.exclude_pattern,
			})
		end,
		desc = "Grep",
	},
	{
		mode = "n",
		key = "<leader>sn",
		action = function()
			Snacks.picker.notifications({
				on_show = function()
					vim.cmd.stopinsert()
				end,
				layout = "ivy",
			})
		end,
		desc = "Notification History",
	},
	{
		mode = "n",
		key = "<leader>sq",
		action = function()
			Snacks.picker.qflist({
				on_show = function()
					vim.cmd.stopinsert()
				end,
				layout = "ivy",
			})
		end,
		desc = "Quickfix List",
	},
	{
		mode = "n",
		key = '<leader>s"',
		action = function()
			Snacks.picker.registers()
		end,
		desc = "Registers",
	},
	{
		mode = "n",
		key = "<leader>s/",
		action = function()
			Snacks.picker.search_history({
				on_show = function()
					vim.cmd.stopinsert()
				end,
				layout = "ivy",
			})
		end,
		desc = "Search History",
	},
	{
		mode = "n",
		key = "<leader>sC",
		action = function()
			Snacks.picker.colorschemes()
		end,
		desc = "Colorschemes",
	},
}

for _, map in ipairs(mappings) do
	vim.keymap.set(map.mode, map.key, map.action, { desc = map.desc })
end

-- setup my custom ui select
utils.setup_ui_select()

return {
	enabled = true,
	prompt = "   ",
	ui_select = false,
	layout = { cycle = true, preset = "ivy" },
	win = {
		input = {
			keys = {
				["/"] = "toggle_focus",
				["<C-Down>"] = { "history_forward", mode = { "i", "n" } },
				["<C-Up>"] = { "history_back", mode = { "i", "n" } },
				["<C-c>"] = { "cancel", mode = "i" },
				["<C-w>"] = { "<c-s-w>", mode = { "i" }, expr = true, desc = "delete word" },
				["<CR>"] = { "confirm", mode = { "n", "i" } },
				["<Down>"] = { "list_down", mode = { "i", "n" } },
				["<Esc>"] = "cancel",
				["<S-CR>"] = { { "pick_win", "jump" }, mode = { "n", "i" } },
				["<S-Tab>"] = { "select_and_prev", mode = { "i", "n" } },
				["<Tab>"] = { "select_and_next", mode = { "i", "n" } },
				["<Up>"] = { "list_up", mode = { "i", "n" } },
				["<a-d>"] = { "inspect", mode = { "n", "i" } },
				["<a-f>"] = { "toggle_follow", mode = { "i", "n" } },
				["<a-h>"] = { "toggle_hidden", mode = { "i", "n" } },
				["<a-i>"] = { "toggle_ignored", mode = { "i", "n" } },
				["<a-m>"] = { "toggle_maximize", mode = { "i", "n" } },
				["<a-p>"] = { "toggle_preview", mode = { "i", "n" } },
				["<a-w>"] = { "cycle_win", mode = { "i", "n" } },
				["<c-a>"] = { "select_all", mode = { "n", "i" } },
				["<c-b>"] = { "preview_scroll_up", mode = { "i", "n" } },
				["<c-d>"] = { "list_scroll_down", mode = { "i", "n" } },
				["<c-f>"] = { "preview_scroll_down", mode = { "i", "n" } },
				["<c-g>"] = { "toggle_live", mode = { "i", "n" } },
				["<c-j>"] = { "list_down", mode = { "i", "n" } },
				["<c-k>"] = { "list_up", mode = { "i", "n" } },
				["<c-n>"] = { "list_down", mode = { "i", "n" } },
				["<c-p>"] = { "list_up", mode = { "i", "n" } },
				["<c-q>"] = { "qflist", mode = { "i", "n" } },
				["<c-x>"] = { "edit_split", mode = { "i", "n" } },
				["<c-t>"] = { "tab", mode = { "n", "i" } },
				["<c-u>"] = { "list_scroll_up", mode = { "i", "n" } },
				["<c-v>"] = { "edit_vsplit", mode = { "i", "n" } },
				["<c-r>#"] = { "insert_alt", mode = "i" },
				["<c-r>%"] = { "insert_filename", mode = "i" },
				["<c-r><c-a>"] = { "insert_cWORD", mode = "i" },
				["<c-r><c-f>"] = { "insert_file", mode = "i" },
				["<c-r><c-l>"] = { "insert_line", mode = "i" },
				["<c-r><c-p>"] = { "insert_file_full", mode = "i" },
				["<c-r><c-w>"] = { "insert_cword", mode = "i" },
				["<c-w>H"] = "layout_left",
				["<c-w>J"] = "layout_bottom",
				["<c-w>K"] = "layout_top",
				["<c-w>L"] = "layout_right",
				["?"] = "toggle_help_input",
				["G"] = "list_bottom",
				["gg"] = "list_top",
				["j"] = "list_down",
				["k"] = "list_up",
				["q"] = "close",
			},
			b = {
				minipairs_disable = true,
			},
		},
		-- result list window
		list = {
			keys = {
				["/"] = "toggle_focus",
				["<2-LeftMouse>"] = "confirm",
				["<CR>"] = "confirm",
				["<Down>"] = "list_down",
				["<Esc>"] = "cancel",
				["<S-CR>"] = { { "pick_win", "jump" } },
				["<S-Tab>"] = { "select_and_prev", mode = { "n", "x" } },
				["<tab>"] = { "qflist", mode = { "n", "i" } },
				-- ["<Tab>"] = { "select_and_next", mode = { "n", "x" } },
				["<Up>"] = "list_up",
				["<a-d>"] = "inspect",
				["<a-f>"] = "toggle_follow",
				["<a-h>"] = "toggle_hidden",
				["<a-i>"] = "toggle_ignored",
				["<a-m>"] = "toggle_maximize",
				["<a-p>"] = "toggle_preview",
				["<a-w>"] = "cycle_win",
				["<c-a>"] = "select_all",
				["<c-b>"] = "preview_scroll_up",
				["<c-d>"] = "list_scroll_down",
				["<c-f>"] = "preview_scroll_down",
				["<c-j>"] = "list_down",
				["<c-k>"] = "list_up",
				["<c-n>"] = "list_down",
				["<c-p>"] = "list_up",
				["<c-q>"] = "qflist",
				["<c-x>"] = "edit_split",
				["<c-t>"] = "tab",
				["<c-u>"] = "list_scroll_up",
				["<c-v>"] = "edit_vsplit",
				["<c-w>H"] = "layout_left",
				["<c-w>J"] = "layout_bottom",
				["<c-w>K"] = "layout_top",
				["<c-w>L"] = "layout_right",
				["?"] = "toggle_help_list",
				["G"] = "list_bottom",
				["gg"] = "list_top",
				["i"] = "focus_input",
				["j"] = "list_down",
				["k"] = "list_up",
				["q"] = "close",
				["zb"] = "list_scroll_bottom",
				["zt"] = "list_scroll_top",
				["zz"] = "list_scroll_center",
			},
			wo = {
				conceallevel = 2,
				concealcursor = "nvc",
			},
		},
		-- preview window
		preview = {
			keys = {
				["<Esc>"] = "cancel",
				["q"] = "close",
				["i"] = "focus_input",
				["<a-w>"] = "cycle_win",
			},
		},
	},
}

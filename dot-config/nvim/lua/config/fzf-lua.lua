local G = require("core")
local fzf = require("fzf-lua")
local config = fzf.config
local actions = fzf.actions
local utils = require("utils.picker")

vim.api.nvim_create_user_command("ShowTasks", function()
	utils.open_task_menu()
end, { nargs = 0 })

local map = vim.keymap.set
-- stylua: ignore start
map({ "n", "i", "v", "t" }, "<M-]>", "<CMD>ShowTasks<CR>", { desc = "Show Tasks" })
-- Find
map("n", "<leader>p", function() fzf.files() end, { desc = "Find Files" })
map("n", "<leader>sb", function() fzf.buffers() end, { desc = "Find Buffers" })
map("n", "<leader>sb", function() fzf.buffers() end, { desc = "Find Buffers" })
map("n", "<leader>sg", function() fzf.live_grep() end, { desc = "Grep" })
map("n", "<leader>sq", function() fzf.quickfix() end, { desc = "Quickfix List" })
map("n", "<leader>so", function() fzf.oldfiles() end, { desc = "Old Files" })
-- Git
map("n", "<leader>gb", function() fzf.git_branches() end, { desc = "Git Branches" })
map("n", "<leader>gl", function() fzf.git_commits() end, { desc = "Git Logs" })
map("n", "<leader>gt", function() fzf.git_tags() end, { desc = "Git Tags" })
map("n", "<leader>gs", function() fzf.git_stash() end, { desc = "Git Stash" })
-- Miscs
map("n", "<leader>s/", function() fzf.search_history() end, { desc = "Search History" })
map("n", "<leader>s:", function() fzf.command_history() end, { desc = "Commit History" })
map("n", '<leader>s"', function() fzf.registers() end, { desc = "Registers" })
map("n", "<leader>sC", function() fzf.awesome_colorschemes() end, { desc = "Colorschemes" })
map("n", "<leader>gs", function() fzf.git_stash() end, { desc = "Git Stash" })

-- stylua: ignore end

-- ref: http://www.lazyvim.org/extras/editor/fzf
-- fzf windows keymaps
config.defaults.keymap.fzf["ctrl-q"] = "select-all+accept"
config.defaults.keymap.fzf["ctrl-u"] = "half-page-up"
config.defaults.keymap.fzf["ctrl-d"] = "half-page-down"
config.defaults.keymap.fzf["ctrl-x"] = "jump"
config.defaults.keymap.fzf["ctrl-f"] = "preview-page-down"
config.defaults.keymap.fzf["ctrl-b"] = "preview-page-up"
config.defaults.keymap.builtin["<c-f>"] = "preview-page-down"
config.defaults.keymap.builtin["<c-b>"] = "preview-page-up"

fzf.register_ui_select(function(fzf_opts, items)
	return {
		prompt = " ",
		winopts = {
			title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
			title_pos = "center",
			width = 0.4,
			-- 	-- height is number of items, with a max of 80% screen height
			height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
		},
	}
end)

fzf.setup({
	fzf_colors = true,
	fzf_opts = {
		["--no-scrollbar"] = true,
	},
	winopts = {
		border = G.picker_border,
		preview = {
			border = G.picker_border,
			scrollchars = { "┃", "" },
		},
		width = 0.8,
		height = 0.8,
		row = 0.5,
		col = 0.5,
	},
	files = {
		previewer = "bat",
		cwd_prompt = false,
		actions = {
			["alt-i"] = { actions.toggle_ignore },
			["alt-h"] = { actions.toggle_hidden },
		},
	},
	grep = {
		actions = {
			["alt-i"] = { actions.toggle_ignore },
			["alt-h"] = { actions.toggle_hidden },
		},
	},
	lsp = {
		code_actions = {
			previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
		},
	},
	actions = {
		["enter"] = actions.file_edit_or_qf,
		["ctrl-x"] = actions.file_split,
		["ctrl-v"] = actions.file_vsplit,
		["ctrl-t"] = actions.file_tabedit,
		["alt-q"] = actions.file_sel_to_qf,
		["alt-Q"] = actions.file_sel_to_ll,
		["alt-i"] = actions.toggle_ignore,
		["alt-h"] = actions.toggle_hidden,
		["alt-f"] = actions.toggle_follow,
	},
})

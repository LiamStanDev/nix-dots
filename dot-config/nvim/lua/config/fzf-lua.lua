local G = require("core")
local fzf_lua = require("fzf-lua")
local utils = require("utils.picker")
local actions = require("fzf-lua").actions
local map = vim.keymap.set

vim.api.nvim_create_user_command("ShowTasks", function()
	utils.open_task_menu()
end, { nargs = 0 })

map({ "n", "i", "v", "t" }, "<M-]>", "<CMD>ShowTasks<CR>", { desc = "Show Tasks" })

fzf_lua.register_ui_select()

fzf_lua.setup({
	winopts = {
		border = G.picker_border,
		preview = {
			border = G.picker_border,
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

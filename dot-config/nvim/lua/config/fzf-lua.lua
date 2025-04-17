local G = require("core")
local fzf = require("fzf-lua")
local config = fzf.config
local actions = fzf.actions
local utils = require("utils.picker")

vim.api.nvim_create_user_command("ShowTasks", function()
	utils.open_task_menu()
end, { nargs = 0 })

local map = vim.keymap.set
map({ "n", "i", "v", "t" }, "<M-]>", "<CMD>ShowTasks<CR>", { desc = "Show Tasks" })

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
	return vim.tbl_deep_extend("force", fzf_opts, {
		prompt = " ",
		winopts = {
			title = " " .. vim.trim((fzf_opts.prompt or "Select"):gsub("%s*:%s*$", "")) .. " ",
			title_pos = "center",
		},
	}, fzf_opts.kind == "codeaction" and {
		winopts = {
			layout = "vertical",
			-- height is number of items minus 15 lines for the preview, with a max of 80% screen height
			height = math.floor(math.min(vim.o.lines * 0.8 - 16, #items + 2) + 0.5) + 16,
			width = 0.5,
			preview = not vim.tbl_isempty(LazyVim.lsp.get_clients({ bufnr = 0, name = "vtsls" })) and {
				layout = "vertical",
				vertical = "down:15,border-top",
				hidden = "hidden",
			} or {
				layout = "vertical",
				vertical = "down:15,border-top",
			},
		},
	} or {
		winopts = {
			width = 0.5,
			-- height is number of items, with a max of 80% screen height
			height = math.floor(math.min(vim.o.lines * 0.8, #items + 2) + 0.5),
		},
	})
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

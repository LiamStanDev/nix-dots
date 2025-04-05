-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymaps = {
	-- Clear highlights
	{ mode = "n", key = "<Esc>", action = "<CMD>nohlsearch<CR>", desc = "Clear highlights" },

	-- No copy paste and delete
	{ mode = { "n", "v", "x" }, key = "x", action = '"_x', desc = "Disable copy when delete" },
	{ mode = { "n", "v", "x" }, key = "X", action = '"_X', desc = "Disable copy when delete" },

	-- Disable arrow keys in normal mode
	{ mode = "n", key = "<left>", action = '<CMD>echo "Use h to move!!"<CR>' },
	{ mode = "n", key = "<right>", action = '<CMD>echo "Use l to move!!"<CR>' },
	{ mode = "n", key = "<up>", action = '<CMD>echo "Use k to move!!"<CR>' },
	{ mode = "n", key = "<down>", action = '<CMD>echo "Use j to move!!"<CR>' },

	-- Move line/block
	{ mode = { "n", "i" }, key = "<A-j>", action = "<CMD>m .+1<CR>==", desc = "Move line/block down" },
	{ mode = { "n", "i" }, key = "<A-k>", action = "<CMD>m .-2<CR>==", desc = "Move line/block up" },
	{ mode = "x", key = "<A-j>", action = "<CMD>m '>+1<CR>gv-gv", desc = "Move line/block down" },
	{ mode = "x", key = "<A-k>", action = "<CMD>m '<-2<CR>gv-gv", desc = "Move line/block up" },

	-- Head and tail of line
	{ mode = "n", key = "<S-l>", action = "<CMD>bnext<CR>", desc = "Move to the end of the line" },
	{ mode = "n", key = "<S-h>", action = "<CMD>bprev<CR>", desc = "Move to the start of the line" },

	-- Resize with arrows
	{ mode = "n", key = "<M-->", action = "<CMD>resize -10<CR>", desc = "Increase Hight" },
	{ mode = "n", key = "<M-=>", action = "<CMD>resize +10<CR>", desc = "Decrease Hight" },
	{ mode = "n", key = "<M-,>", action = "<CMD>vertical resize -10<CR>", desc = "Increase Width" },
	{ mode = "n", key = "<M-.>", action = "<CMD>vertical resize +10<CR>", desc = "Decrease Width" },

	-- Buffer split
	{ mode = "n", key = "<leader>bl", action = "<CMD>vsplit | wincmd p | b# | wincmd l<CR>", desc = "Split left" },
	{ mode = "n", key = "<leader>bj", action = "<CMD>split | wincmd p | b# | wincmd j<CR>", desc = "Split down" },

	-- Cursor History Navigation
	{ mode = "n", key = "<A-l>", action = "<C-i>", desc = "Next location" },
	{ mode = "n", key = "<A-h>", action = "<C-o>", desc = "Previous location" },

	-- Better Scroll
	{
		mode = { "n", "i", "v", "x" },
		key = "<C-d>",
		action = "<C-d>zz",
		desc = "Center cursor after moving down half-page",
	},
	{
		mode = { "n", "i", "v", "x" },
		key = "<C-u>",
		action = "<C-u>zz",
		desc = "Center cursor after moving up half-page",
	},

	-- Quick Indenting
	{ mode = "v", key = "<", action = "<gv", desc = "Indent left" },
	{ mode = "v", key = ">", action = ">gv", desc = "Indent right" },

	-- Save file
	{ mode = "n", key = "<leader>w", action = "<CMD>silent! w!<CR>", desc = "Save file" },
	{ mode = "n", key = "<leader>W", action = "<CMD>silent! wa!<CR>", desc = "Save all files" },

	-- Quit
	{ mode = "n", key = "<leader>q", action = "<CMD>confirm q<CR>", desc = "Quit" },

	-- Configuration
	-- { mode = "n", key = "<leader>;", action = "<CMD>e $MYVIMRC<CR>", desc = "Configuration" },
}

-- Register all key mappings
for _, map in ipairs(keymaps) do
	vim.keymap.set(map.mode, map.key, map.action, vim.tbl_extend("force", { desc = map.desc }, map.opts or {}))
end

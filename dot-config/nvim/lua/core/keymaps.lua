-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local map = vim.keymap.set

-- Clear highlights
map("n", "<Esc>", "<CMD>nohlsearch<CR>")

-- No copy paste and delete
-- map({ "v", "x" }, "p", "_P", { desc = "Disable copy when paste" })
map({ "n", "v", "x" }, "x", '"_x', { desc = "Disable copy when delete" })
map({ "n", "v", "x" }, "X", '"_X', { desc = "Disable copy when delete" })

-- Split window navigation (use default keymap instead)
-- map("n", "<C-h>", "<C-w>h", { desc = "Move focus to the left window" })
-- map("n", "<C-l>", "<C-w>l", { desc = "Move focus to the right window" })
-- map("n", "<C-j>", "<C-w>j", { desc = "Move focus to the lower window" })
-- map("n", "<C-k>", "<C-w>k", { desc = "Move focus to the upper window" })

-- Disable arrow keys in normal mode
map("n", "<left>", '<CMD>echo "Use h to move!!"<CR>')
map("n", "<right>", '<CMD>echo "Use l to move!!"<CR>')
map("n", "<up>", '<CMD>echo "Use k to move!!"<CR>')
map("n", "<down>", '<CMD>echo "Use j to move!!"<CR>')

-- Move line/block
map({ "n", "i" }, "<A-j>", ":m .+1<CR>==", { desc = "Move line/block down" })
map({ "n", "i" }, "<A-k>", ":m .-2<CR>==", { desc = "Move line/block up" })
map("x", "<A-j>", ":m '>+1<CR>gv-gv", { desc = "Move line/block down" })
map("x", "<A-k>", ":m '<-2<CR>gv-gv", { desc = "Move line/block up" })

-- Head and tail of line
map("n", "<S-l>", "$", { desc = "Move to the end of the line" })
map("n", "<S-h>", "^", { desc = "Move to the start of the line" })

-- Resize with arrows
map("n", "<C-Up>", ":resize -2<CR>", { desc = "Resize window up" })
map("n", "<C-Down>", ":resize +2<CR>", { desc = "Resize window down" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Resize window left" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Resize window right" })

-- buffer split
map("n", "<leader>bl", ":vsplit | wincmd p | enew | wincmd l<CR>", { desc = "Split left" })
map("n", "<leader>bj", ":split | wincmd p | enew | wincmd j<CR>", { desc = "Split down" })

-- Buffer Navigation
-- map("n", "<A-l>", ":bnext<CR>", { desc = "Next buffer" })
-- map("n", "<A-h>", ":bprevious<CR>", { desc = "Previous buffer" })

-- Cursor History Navigation
map("n", "<A-l>", "<C-i>", { desc = "Next location" })
map("n", "<A-h>", "<C-o>", { desc = "Previous location" })

-- Better Scroll
map({ "n", "i", "v", "x" }, "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down half-page" })
map({ "n", "i", "v", "x" }, "<C-u>", "<C-u>zz", { desc = "Center cursor after moving down half-page" })

-- Quick Indenting
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Command mode completion selection
map("c", "<C-j>", "pumvisible() ? '<C-n>' : '<C-j>'", { expr = true })
map("c", "<C-k>", "pumvisible() ? '<C-p>' : '<C-k>'", { expr = true })

-- Save file
map("n", "<leader>w", "<CMD>silent! w!<CR>", { desc = "Save file" })
map("n", "<leader>W", "<CMD>silent! wa!<CR>", { desc = "Save all file" })

-- Quit
map("n", "<leader>q", "<CMD>confirm q<CR>", { desc = "Quit" })
map("n", "<leader>;", ":e $MYVIMRC<CR>", { desc = "Configuration" })

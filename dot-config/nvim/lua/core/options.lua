local cache_dir = vim.env.HOME .. "/.cache/nvim/"

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- General options
local options = {
	-- file formate
	ff = "unix",
	ffs = "unix,dos",
	-- line number
	relativenumber = true,
	number = true,

	-- indentation
	tabstop = 4,
	shiftwidth = 4,
	expandtab = true,
	autoindent = true,
	-- breakindent = true, -- long line wrap will align
	wrap = false, -- line wrapping (conflict with break indent)

	-- whit space display
	list = true,
	listchars = { tab = "» ", trail = "·", nbsp = "␣" },

	-- search settings
	ignorecase = true,
	smartcase = true,
	hlsearch = true, -- highlight search
	infercase = true,

	-- cursor
	cursorline = true,
	scrolloff = 15, -- Minimal number of screen lines to keep above and below the cursor

	-- appearance
	termguicolors = true,
	signcolumn = "yes",

	-- typing
	undofile = true, -- can persistent undo

	-- split windows
	splitbelow = true,
	splitright = true,

	-- mouse
	mouse = "a",

	hidden = true,
	magic = true,
	virtualedit = "block",
	wildignorecase = true,

	-- swap need to set false, true lead to dead lock
	swapfile = false,
	directory = cache_dir .. "swap/",
	undodir = cache_dir .. "undo/",
	backupdir = cache_dir .. "backup/",
	viewdir = cache_dir .. "view/",
	spellfile = cache_dir .. "spell/en.uft-8.add",

	-- other setting
	history = 2000,
	timeout = true,
	ttimeout = true,
	timeoutlen = 500,
	ttimeoutlen = 10,
	updatetime = 100,
	redrawtime = 1500,

	showmode = false,

	-- Preview substitutions live
	inccommand = "split",

	-- NOTE: this will affect all window (Nvim 0.11)
	-- winborder = "single",
}

for option, val in pairs(options) do
	vim.opt[option] = val
end

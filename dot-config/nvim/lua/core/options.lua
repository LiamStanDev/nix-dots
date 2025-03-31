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
	ff = "unix", -- file formate
	ffs = "unix,dos", -- file formate
	number = true, -- line number
	relativenumber = true,
	tabstop = 2, -- number of spaces tabs count when display
	shiftwidth = 2, -- size of an indent
	smartindent = true, -- auto indent
	expandtab = true, -- use space instead of tabs
	-- breakindent = true, -- long line wrap will align
	wrap = false, -- line wrapping (conflict with break indent)
	list = true, -- invisible characters
	listchars = { tab = "» ", trail = "·", nbsp = "␣" },
	ignorecase = true,
	smartcase = true,
	hlsearch = true, -- highlight search
	cursorline = true, -- highlighting of the current line
	scrolloff = 4, -- minimal number of screen lines to keep above and below the cursor
	termguicolors = true, -- true color
	signcolumn = "yes", -- always show signcolumn, otherwise it would shift text each time
	undofile = true, -- can persistent undo
	undolevels = 10000,
	splitbelow = true,
	splitright = true,
	mouse = "a",
	pumblend = 10, -- popup blend
	hidden = true,
	virtualedit = "block", -- allow cursor to move where there is no text in visual block mode
	wildignorecase = true,
	swapfile = false,
	directory = cache_dir .. "swap/",
	undodir = cache_dir .. "undo/",
	backupdir = cache_dir .. "backup/",
	viewdir = cache_dir .. "view/",
	spellfile = cache_dir .. "spell/en.uft-8.add",
	history = 2000,
	timeout = true,
	ttimeout = true,
	timeoutlen = 500,
	ttimeoutlen = 10,
	updatetime = 100,
	redrawtime = 1500,
	showmode = false, -- dont show mode since we use statusline
	virtualedit = "block", -- Allow cursor to move where there is no text in visual block mode
	inccommand = "split", -- preview substitutions live
	grepprg = "rg --vimgrep",
	spelllang = { "en" },
	foldcolumn = "1",
	foldlevel = 99, -- Using ufo provider need a large value, feel free to decrease the value
	foldlevelstart = 99,
	fillchars = {
		foldopen = "",
		foldclose = "",
		fold = " ",
		foldsep = " ",
		diff = "╱",
		eob = " ",
	},
	foldenable = true,
	-- winborder = "single", -- this will affect all window (Nvim 0.11)
}

for option, val in pairs(options) do
	vim.opt[option] = val
end

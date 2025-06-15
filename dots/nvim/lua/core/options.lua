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
	ff = "unix", -- file format
	ffs = "unix,dos", -- file formats
	number = true, -- show line numbers
	relativenumber = true, -- show relative line numbers
	tabstop = 2, -- number of spaces per tab
	shiftwidth = 2, -- size of an indent
	smartindent = true, -- enable smart indenting
	expandtab = true, -- use spaces instead of tabs
	-- breakindent = true, -- visually align wrapped lines
	wrap = false, -- disable line wrapping (conflicts with breakindent)
	list = true, -- show invisible characters
	listchars = { tab = "» ", trail = "·", nbsp = "␣" },
	ignorecase = true, -- ignore case in search patterns
	smartcase = true, -- override ignorecase if search contains uppercase
	hlsearch = true, -- highlight search results
	cursorline = true, -- highlight the current line
	scrolloff = 4, -- minimal number of screen lines to keep above and below the cursor
	termguicolors = true, -- enable true color support
	signcolumn = "yes", -- always show signcolumn to avoid text shifting
	undofile = true, -- enable persistent undo
	undolevels = 10000, -- maximum number of changes that can be undone
	splitbelow = true, -- horizontal splits will be below
	splitright = true, -- vertical splits will be to the right
	mouse = "a", -- enable mouse support
	-- pumblend = 10, -- popup blend (let theme choose)
	hidden = true, -- allow buffer switching without saving
	virtualedit = "block", -- allow cursor to move where there is no text in visual block mode
	wildignorecase = true, -- ignore case when completing file names and directories
	swapfile = false, -- disable swap file
	directory = cache_dir .. "swap/", -- directory for swap files
	undodir = cache_dir .. "undo/", -- directory for undo files
	backupdir = cache_dir .. "backup/", -- directory for backup files
	viewdir = cache_dir .. "view/", -- directory for view files
	spellfile = cache_dir .. "spell/en.uft-8.add", -- file for spell checking
	history = 2000, -- number of commands and search history to remember
	timeout = true, -- enable timeout for mapped sequences
	ttimeout = true, -- enable timeout for key codes
	timeoutlen = 500, -- time to wait for a mapped sequence (ms)
	ttimeoutlen = 10, -- time to wait for key codes (ms)
	updatetime = 100, -- faster completion
	redrawtime = 1500, -- time in milliseconds for redrawing
	showmode = false, -- do not show mode since statusline is used
	inccommand = "split", -- preview substitutions live
	grepprg = "rg --vimgrep", -- use ripgrep for :grep
	spelllang = { "en" }, -- spell check language
	foldcolumn = "1", -- show fold column
	foldlevel = 99, -- high value for ufo provider, decrease if needed
	foldlevelstart = 99, -- initial fold level
	fillchars = {
		foldopen = "",
		foldclose = "",
		fold = " ",
		foldsep = " ",
		diff = "╱",
		eob = " ",
	},
	foldenable = true, -- enable folding
	-- winborder = "single", -- affects all windows (Nvim 0.11)
}

for option, val in pairs(options) do
	vim.opt[option] = val
end

-- diable intro text
vim.opt.shortmess:append("I")

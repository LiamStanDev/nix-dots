local G = require("core")

-- Install the `lazy.nvim` plugin manager if not already present
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		error("Error cloning lazy.nvim:\n" .. out)
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Set up lazy.nvim with plugin specifications and UI options
require("lazy").setup({
	spec = {
		{ import = "plugins" }, -- Import all ~/.config/nvim/lua/plugins/*.lua here
	},
	checker = { enabled = false },
	rocks = { enabled = false },
}, {
	ui = {
		-- If using a Nerd Font: set icons to an empty table to use lazy.nvim's default Nerd Font icons.
		-- Otherwise, define a Unicode icons table below.
		icons = {
			cmd = "⌘",
			config = "🛠",
			event = "📅",
			ft = "📂",
			init = "⚙",
			keys = "🗝",
			plugin = "🔌",
			runtime = "💻",
			require = "🌙",
			source = "📄",
			start = "🚀",
			task = "📌",
			lazy = "💤 ",
		},
	},
})

-- Set the colorscheme as defined in the core configuration
vim.cmd("colorscheme " .. G.colorscheme)

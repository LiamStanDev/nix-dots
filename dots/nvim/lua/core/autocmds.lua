--- Creates a new autocommand group with the given name.
-- @param name The name of the autocommand group.
-- @return The created autocommand group.
local function augroup(name)
	return vim.api.nvim_create_augroup("liamvim_" .. name, { clear = true })
end

-- Set `.conf` files as filetype `conf`.
vim.api.nvim_command("autocmd BufNewFile,BufRead *.conf setfiletype conf")

-- Set `justfile` as filetype `make`.
vim.api.nvim_command("autocmd BufNewFile,BufRead justfile setfiletype make")

-- Highlight text on yank.
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- Automatically resize splits when the window is resized.
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- Enable wrapping and spell checking for specific text filetypes.
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

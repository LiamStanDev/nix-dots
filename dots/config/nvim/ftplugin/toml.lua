vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.bo.expandtab = true
vim.bo.autoindent = true
vim.bo.smartindent = true
vim.bo.copyindent = true

if vim.fn.expand("%:t"):lower() == "cargo.toml" then
	local group = vim.api.nvim_create_augroup("RustReloadWorkspace", { clear = false })
	local bufnr = vim.api.nvim_get_current_buf()

	vim.api.nvim_clear_autocmds({
		buffer = bufnr,
		group = group,
	})

	local ra = require("utils.rust_analyzer")
	vim.api.nvim_create_autocmd("BufWritePost", {
		buffer = vim.api.nvim_get_current_buf(),
		group = group,
		callback = function()
			ra.reload_workspace()
		end,
	})
end

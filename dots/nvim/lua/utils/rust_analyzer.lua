-- ref: https://rust-analyzer.github.io//book/contributing/lsp-extensions.html

local M = {}
local lsp_utils = require("utils.lsp")

-- you can get current buffer number by calling `vim.api.nvim_get_current_buf()`
function M.reload_worspace(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "rust_analyzer" })
	for _, client in ipairs(clients) do
		vim.notify("Reloading Cargo Workspace", vim.log.levels.INFO)
		client:request("rust-analyzer/reloadWorkspace", nil, function(err)
			if err then
				error(tostring(err))
			end
			vim.notify("Cargo workspace reloaded")
		end, 0)
	end
end

-- This function check whether current file is std lib or third-party lib.
-- you can get current file name by calling `vim.api.nvim_buf_get_name(0)`
function M.is_library(fname)
	local user_home = vim.fs.normalize(vim.env.HOME)
	local cargo_home = os.getenv("CARGO_HOME") or user_home .. "/.cargo"
	local registry = cargo_home .. "/registry/src"
	local git_registry = cargo_home .. "/git/checkouts"

	local rustup_home = os.getenv("RUSTUP_HOME") or user_home .. "/.rustup"
	local toolchains = rustup_home .. "/toolchains"

	for _, item in ipairs({ toolchains, registry, git_registry }) do
		if vim.fs.relpath(item, fname) then
			local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
			return #clients > 0 and clients[#clients].config.root_dir or nil
		end
	end
end

return M

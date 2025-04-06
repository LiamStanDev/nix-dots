-- ref: https://rust-analyzer.github.io//book/contributing/lsp-extensions.html

local M = {}
local utils = require("utils.lsp")

local function reload_workspace_handler(err)
	if err then
		vim.notify(tostring(err), vim.log.levels.ERROR)
		return
	end
	vim.notify("Cargo workspace reloaded")
end

function M.reload_workspace()
	vim.notify("Reloading Cargo Workspace")
	local client = M.get_client()
	if client == nil then
		vim.notify("No rust-analyzer client found", vim.log.levels.WARN)
		return
	end
	client:request("rust-analyzer/reloadWorkspace", nil, reload_workspace_handler)
end

function M.get_client()
	return utils.get_client("rust_analyzer")
end

return M

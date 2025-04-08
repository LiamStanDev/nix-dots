-- ref: https://rust-analyzer.github.io//book/contributing/lsp-extensions.html

local M = {}
local utils = require("utils.lsp")

function M.reload_workspace()
	vim.notify("Reloading Cargo Workspace")
	local client = utils.get_client("rust_analyzer")
	if client == nil then
		vim.notify("No rust-analyzer client found", vim.log.levels.WARN)
		return
	end

	client:request("rust-analyzer/reloadWorkspace", nil, function(err)
		if err then
			vim.notify(tostring(err), vim.log.levels.ERROR)
		end
		vim.notify("Cargo workspace reloaded")
	end)
end

return M

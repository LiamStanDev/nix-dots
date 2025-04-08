local M = {}

function M.build_default_capabilities()
	-- Initialize LSP client capabilities.
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	-- Extend capabilities with additional LSP features from the `blink.cmp` plugin.
	capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
	return capabilities
end

return M

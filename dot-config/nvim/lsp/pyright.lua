local function build_capabilities()
	-- Initialize LSP client capabilities.
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	-- Extend capabilities with additional LSP features from the `blink.cmp` plugin.
	capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
	return capabilities
end

return {
	-- NOTE: if you want to use vevn package, please install
	-- pyright in current activated vevn
	cmd = { "pyright-langserver", "--stdio" },
	capabilities = build_capabilities(),
	root_markers = {
		"pyproject.toml",
		"setup.py",
		"setup.cfg",
		"requirements.txt",
		"Pipfile",
		"pyrightconfig.json",
		".git",
	},
	filetypes = { "python" },
	settings = {
		python = {
			analysis = {
				autoSearchPaths = true,
				typeCheckingMode = "strict",
				diagnosticMode = "workspace",
				inlayHints = {
					variableTypes = true,
					functionReturnTypes = true,
				},
				logLevel = "Information",
				autoImportCompletions = true,
				useLibraryCodeForTypes = true,
			},
		},
	},
}

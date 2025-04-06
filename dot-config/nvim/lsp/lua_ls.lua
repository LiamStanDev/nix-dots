local function build_capabilities()
	-- Initialize LSP client capabilities.
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	-- Extend capabilities with additional LSP features from the `blink.cmp` plugin.
	capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
	return capabilities
end

return {
	cmd = { "lua-language-server" },
	root_markers = {
		".luarc.json",
		".luarc.jsonc",
		".luacheckrc",
		".stylua.toml",
		"stylua.toml",
		"selene.toml",
		"selene.yml",
		".git",
	},
	filetypes = { "lua" },
	capabilities = build_capabilities(),
	settings = {
		Lua = {
			diagnostics = {
				-- Get the language server to recognize the `vim` global
				globals = { "vim", "MiniFiles", "Snacks" },
			},
			completion = {
				callSnippet = "Replace",
			},
			runtime = {
				version = "LuaJIT",
			},
			workspace = {
				-- Let lsp knows nvim runtime so it can provide completion
				library = { vim.env.VIMRUNTIME },
				checkThirdParty = false,
			},
			hint = { enable = true },
		},
	},
}

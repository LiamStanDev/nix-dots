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
				library = { vim.env.VIMRUNTIME },
				checkThirdParty = false,
			},
			hint = { enable = true },
		},
	},
}

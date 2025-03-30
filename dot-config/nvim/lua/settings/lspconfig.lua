local function client_supports_method(client, method, bufnr)
	if vim.fn.has("nvim-0.11") == 1 then
		return client:supports_method(method, bufnr)
	else
		return client.supports_method(method, { bufnr = bufnr })
	end
end

return function()
	local capabilities = {
		textDocument = {
			semanticTokens = {
				multilineTokenSupport = true,
			},
		},
	}
	-- capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
	capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

	local servers = require("core.globals").lsp_servers
	for _, server in ipairs(servers) do
		if server == "clangd" then
			capabilities.offsetEncoding = { "utf-16" }
		end

		local opts = {
			capabilities = capabilities,
		}

		-- find settings.lsp-settings/*
		local require_ok, conf_opts = pcall(require, "services.lsp-settings." .. server)
		if require_ok then
			opts = vim.tbl_deep_extend("force", conf_opts, opts)
		end

		if server == "tailwindcss-language-server" then
			require("lspconfig").tailwindcss.setup({})
			goto continue
		else
			require("lspconfig")[server].setup(opts)
		end
		::continue::
	end
end

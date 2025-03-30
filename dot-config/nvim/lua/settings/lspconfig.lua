local function client_supports_method(client, method, bufnr)
	if vim.fn.has("nvim-0.11") == 1 then
		return client:supports_method(method, bufnr)
	else
		return client.supports_method(method, { bufnr = bufnr })
	end
end

return function()
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(event)
			local map = vim.keymap.set
            -- stylua: ignore start
			map("n", "gd", function()vim.lsp.buf.definition()end, { desc = "Go to Definition" })
			map("n", "gr", function () Snacks.picker.lsp_references({ on_show = function() vim.cmd.stopinsert() end, layout = "ivy", }) end, { desc = "Go to References" }) -- map("n", "gr", "<CMD>Trouble lsp_references toggle<CR>", { desc = "Go to References" })
			map("n", "gi", function () Snacks.picker.lsp_implementations({ on_show = function() vim.cmd.stopinsert() end, layout = "ivy", }) end, { desc = "Go to References" }) -- map("n", "gr", "<CMD>Trouble lsp_references toggle<CR>", { desc = "Go to References" })
			map("n", "go", "<CMD>Trouble symbols toggle win.position=right<CR>", { desc = "Outline Symbols" })
			map("n", "gn",function () vim.lsp.buf.rename() end, { desc = "Rename" })
			map("n", "ga",function () vim.lsp.buf.code_action() end, { desc = "Code Action" })
			map("n", "gw", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Show Workspace Diagnostics" })
			map("n", "K",function () vim.lsp.buf.hover() end, { desc = "Hover Documentation" }) map("n", "gk", "<CMD>Lspsaga diagnostic_jump_prev<CR>", { desc = "Previous Diagnostic" })
			map("n", "gI", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle Inlay Hint" })
			map("n", "gR", "<CMD>LspRestart<CR>", { desc = "Lsp Restart" })
			-- ctrl + s is default to vim.lsp.buf.signature_help()
			-- stylua: ignore end

			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if
				client
				and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
			then
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					callback = vim.lsp.buf.clear_references,
				})
			end

			vim.api.nvim_create_autocmd("LspDetach", {
				callback = function(_)
					vim.lsp.buf.clear_references()
				end,
			})
		end,
	})

	-- Diagnostics
	vim.diagnostic.config({
		severity_sort = true,
		float = { border = "rounded", source = "if_many" },
		underline = { severity = vim.diagnostic.severity.ERROR },
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = " ",
				[vim.diagnostic.severity.WARN] = " ",
				[vim.diagnostic.severity.INFO] = " ",
				[vim.diagnostic.severity.HINT] = " ",
			},
		},
		-- virtual_text = {
		-- 	source = "if_many",
		-- 	prefix = "●",
		-- 	spacing = 2,
		-- },
		virtual_lines = { current_line = true },
	})

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

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
			map("n", "gd", "<CMD>Lspsaga goto_definition<CR>", { desc = "Go to Definition" })
			map("n", "gr", "<CMD>Lspsaga finder<CR>", { desc = "Go to References" })
			map("n", "gD", "<CMD>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })
			map("n", "go", "<CMD>Lspsaga outline<CR>", { desc = "Outline Symbols" })
			map("n", "gn", "<CMD>Lspsaga rename ++project<CR>", { desc = "Rename" })
			map("n", "ga", "<CMD>Lspsaga code_action<cr>", { desc = "Code Action" })
			-- map("n", "gT", "<CMD>Lspsaga peek_type_definition<CR>", { desc = "Peek Type Definition" })
			-- map("n", "gt", "<CMD>Lspsaga goto_type_definition<CR>", { desc = "Go to Type Definition" })
			map("n", "gl", "<CMD>Lspsaga show_cursor_diagnostics<CR>", { desc = "Show Cursor Diagnostics" })
			map("n", "gL", "<CMD>Lspsaga show_buf_diagnostics<CR>", { desc = "Show Buffer Diagnostics" })
			map("n", "gw", "<CMD>Lspsaga show_workspace_diagnostics<CR>", { desc = "Show Workspace Diagnostics" })
			map("n", "gh", "<CMD>Lspsaga hover_doc<CR>", { desc = "Hover Documentation" })
			map("n", "gk", "<CMD>Lspsaga diagnostic_jump_prev<CR>", { desc = "Previous Diagnostic" })
			map("n", "gj", "<CMD>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })
			map("n", "gi", vim.lsp.buf.implementation, { desc = "Go to Implementation" })
			map("n", "gI", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle Inlay Hint" })
			map("n", "gR", "<CMD>LspRestart<CR>", { desc = "Lsp Restart" })
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

			if client and client.name == "clangd" then
				map({ "n", "i", "v" }, "<A-s>", "<CMD>ClangdSwitchSourceHeader<CR>")
			end

			vim.api.nvim_create_autocmd("LspDetach", {
				callback = function(_)
					vim.lsp.buf.clear_references()
				end,
			})
		end,
	})

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
		update_in_insert = true,
		virtual_text = {
			source = "if_many",
			prefix = "●",
			spacing = 2,
			format = function(diagnostic)
				local diagnostic_message = {
					[vim.diagnostic.severity.ERROR] = diagnostic.message,
					[vim.diagnostic.severity.WARN] = diagnostic.message,
					[vim.diagnostic.severity.INFO] = diagnostic.message,
					[vim.diagnostic.severity.HINT] = diagnostic.message,
				}
				return diagnostic_message[diagnostic.severity]
			end,
		},
	})

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

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

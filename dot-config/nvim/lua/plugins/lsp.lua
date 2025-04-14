local G = require("core")
local utils = require("utils.lsp")

vim.lsp.enable(G.lsp_servers)

vim.lsp.config("*", {
	capabilities = utils.build_default_capacities(),
	root_markers = { ".git" },
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local map = vim.keymap.set
    --stylua: ignore start
		map("n", "grd", function() Snacks.picker.lsp_definitions({ layout = "ivy", }) end, { desc = "Go to Definition" })
		map("n", "grr", function() Snacks.picker.lsp_references({ layout = "ivy", }) end, { desc = "Go to References" }) -- map("n", "gr", "<CMD>Trouble lsp_references toggle<CR>", { desc = "Go to References" })
		map("n", "gri", function() Snacks.picker.lsp_implementations({ layout = "ivy", }) end, { desc = "Go to References" }) -- map("n", "gr", "<CMD>Trouble lsp_references toggle<CR>", { desc = "Go to References" })
		map("n", "gro", "<CMD>Trouble symbols toggle win.position=right<CR>", { desc = "Outline Symbols" })
		map("n", "grn", function() vim.lsp.buf.rename() end, { desc = "Rename" })
		map("n", "gra", function() vim.lsp.buf.code_action() end, { desc = "Code Action" })
		map("n", "grw", "<CMD>Trouble diagnostics toggle win.position=bottom<CR>", { desc = "Show Workspace Diagnostics" })
		map("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover Documentation" })
		map("n", "grk", function() vim.diagnostic.open_float() end, { desc = "Previous Diagnostic" })
    map("n", "grK", function() local new_config = not vim.diagnostic.config().virtual_lines vim.diagnostic.config({ virtual_lines = new_config }) end, { desc = "Toggle diagnostic virtual_lines" })
		map("n", "grI", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle Inlay Hint" })
		map("n", "grH", function() vim.cmd("checkhealth vim.lsp") end, { desc = "Toggle Inlay Hint" })
		map("n", "grR", function() vim.lsp.stop_client(vim.lsp.get_clients()) vim.defer_fn(function() vim.cmd("edit") end, 2000) end, { desc = "Lsp Restart" })
    -- ctrl + s is default to vim.lsp.buf.signature_help()
    map({"n", "v", "i"}, "<C-s>", function() vim.lsp.buf.signature_help() end, { desc = "Show Signature"})
    map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Go to previous diagnostic" })
    map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Go to next diagnostic" })

    -- remove default
    vim.bo[event.buf].formatexpr = nil
    vim.bo[event.buf].omnifunc = nil
		-- vim.keymap.del("n", "gO", { buffer = event.buf }) -- NOTE: can't unmap
		--stylua: ignore end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
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
	float = { border = "single", source = "always" },
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
	-- 	source = "always",
	-- 	prefix = "●",
	-- 	spacing = 2,
	-- },
	-- virtual_lines = { current_line = true },
})

return {
	-- Services installer
	{
		"williamboman/mason.nvim",
		event = "VeryLazy",
		config = function()
			require("mason").setup({
				PATH = "prepend", -- "prepend", "append", "skip"
				pip = {
					upgrade_pip = true,
				},
				max_concurrent_installers = 10,
			})
		end,
		dependencies = {
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				config = function()
					local service_identifiers = require("utils.lsp").get_service_identifiers(G)
					require("mason-tool-installer").setup({
						ensure_installed = service_identifiers,
					})
				end,
			},
		},
		keys = {
			{ "<leader>um", "<CMD>Mason<CR>", desc = "Mason" },
			{ "<leader>uu", "<CMD>MasonToolsUpdate<CR>", desc = "Mason Tools Update" },
		},
	},

	-- LSP plugins
	{ -- LSP for neovim configuration
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = "ConformInfo",
		keys = {
			{
				"<leader>f",
				function()
					require("conform").format({ timeout_ms = 500, lsp_format = "fallback" })
				end,
				mode = { "n", "v" },
				desc = "Format buffer",
			},
		},
		opts = {
			notify_on_error = false,
			formatters_by_ft = G.formatters,
		},
	},
	{ -- Autolint
		"mfussenegger/nvim-lint",
		opts = {
			events = { "BufWritePost", "BufReadPost", "InsertLeave" },
		},
		config = function(_, opts)
			require("lint").linters_by_ft = G.linters
			local M = {}
			function M.debounce(ms, fn)
				local timer = vim.uv.new_timer()
				if not timer then
					vim.notify("Failed to create timer", vim.log.levels.ERROR)
					return fn -- Fallback to calling the function directly
				end
				return function(...)
					timer:start(ms, 0, function()
						timer:stop()
						vim.schedule_wrap(fn)()
					end)
				end
			end

			vim.api.nvim_create_autocmd(opts.events, {
				group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
				callback = M.debounce(100, require("lint").try_lint),
			})
		end,
	},

	-- rust cargo
	{
		"Saecki/crates.nvim",
		tag = "stable",
		event = { "BufRead Cargo.toml" },
		opts = {
			completion = {
				crates = {
					enabled = true,
				},
			},
			lsp = {
				enabled = true,
				actions = true,
				completion = true,
				hover = true,
			},
		},
	},
}

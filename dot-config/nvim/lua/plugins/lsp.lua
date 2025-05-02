-- Main LSP configuration file: enables and configures LSP features

-- Load core settings and LSP utilities
local G = require("core")
local utils = require("utils.lsp")

-- Enable all LSP servers registered in G.lsp_servers
vim.lsp.enable(G.lsp_servers)

-- Set shared capabilities and project root markers for all LSP servers
vim.lsp.config("*", {
	capabilities = utils.build_default_capabilities(), -- LSP capabilities (e.g., completion)
	root_markers = { ".git" }, -- Project root detection
})

-- Set up keymaps and autocmds when an LSP server attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		-- Use pcall to require fzf-lua, avoid errors if dependency is missing
		local ok, fzf = pcall(require, "fzf-lua")
		if not ok then
			vim.notify("fzf-lua not found (LSP keymaps not set)", vim.log.levels.WARN)
			return
		end
		local map = vim.keymap.set
    -- stylua: ignore start
    -- LSP-related keymaps
    map("n", "gd", function() fzf.lsp_definitions({ winopts = { relative = "cursor", height = 0.3, width = 0.6 } }) end, { desc = "Go to Definition" })
    map("n", "gr", function() fzf.lsp_references({ winopts = { relative = "cursor", height = 0.3, width = 0.6 } }) end, { desc = "Go to References" })
    map("n", "gi", function() fzf.lsp_implementations({ winopts = { relative = "cursor", height = 0.3, width = 0.6 } }) end, { desc = "Go to Implementations" })
    map("n", "gf", function() fzf.lsp_finder({ winopts = { relative = "cursor", height = 0.3, width = 0.6 } }) end, { desc = "Lsp Finder" })
    map("n", "gO", "<CMD>Trouble symbols toggle win.position=right<CR>", { desc = "Outline Symbols" })
    map("n", "gn", function() vim.lsp.buf.rename() end, { desc = "Rename" })
    map("n", "ga", function() fzf.lsp_code_actions({ winopts = { relative = "cursor", width = 0.45, height = 0.6, preview = { vertical = "up:65%", layout = "vertical", }, }, }) end, { desc = "Code Action" })
    map("n", "gw", function() fzf.diagnostics_workspace() end, { desc = "Show Workspace Diagnostics" })
    map("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover Documentation" })
    map("n", "gk", function() vim.diagnostic.open_float() end, { desc = "Show Diagnostic" })
    map("n", "gK", function() local new_config = not vim.diagnostic.config().virtual_lines vim.diagnostic.config({ virtual_lines = new_config }) end, { desc = "Toggle diagnostic virtual_lines" })
    map("n", "gI", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle Inlay Hint" })
    map("n", "gH", function() vim.cmd("checkhealth vim.lsp") end, { desc = "Check LSP Health" })
    map("n", "gR", function() vim.lsp.stop_client(vim.lsp.get_clients()) vim.defer_fn(function() vim.cmd("edit") end, 2000) end, { desc = "Lsp Restart" })
    -- ctrl + s is default to vim.lsp.buf.signature_help()
    map({ "n", "v", "i" }, "<C-s>", function() vim.lsp.buf.signature_help() end, { desc = "Show Signature" })
    map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Go to previous diagnostic" })
    map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Go to next diagnostic" })
		-- stylua: ignore end

		-- Remove default LSP buffer options to avoid conflicts with custom formatting/completion
		vim.bo[event.buf].formatexpr = nil
		vim.bo[event.buf].omnifunc = nil
		-- vim.keymap.del("n", "gO", { buffer = event.buf }) -- NOTE: can't unmap

		-- Enable documentHighlight if supported by the LSP client
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

		-- Clear highlights when LSP detaches
		vim.api.nvim_create_autocmd("LspDetach", {
			callback = function(_)
				vim.lsp.buf.clear_references()
			end,
		})
	end,
})

-- Centralized diagnostic signs for easy theme switching and customization
local diagnostic_signs = {
	[vim.diagnostic.severity.ERROR] = " ",
	[vim.diagnostic.severity.WARN] = " ",
	[vim.diagnostic.severity.INFO] = " ",
	[vim.diagnostic.severity.HINT] = " ",
}

-- Configure diagnostic display styles
vim.diagnostic.config({
	severity_sort = true, -- Sort diagnostics by severity
	float = { border = "single", source = "always" }, -- Floating window style
	underline = { severity = vim.diagnostic.severity.ERROR }, -- Underline only errors
	signs = {
		text = diagnostic_signs,
	},
	-- virtual_text = {
	--   source = "always",
	--   prefix = "●",
	--   spacing = 2,
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

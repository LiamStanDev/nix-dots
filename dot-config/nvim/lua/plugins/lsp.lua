local G = require("core.globals")
local map = vim.keymap.set

vim.lsp.enable(G.lsp_servers)

local function client_supports_method(client, method, bufnr)
	if vim.fn.has("nvim-0.11") == 1 then
		return client:supports_method(method, bufnr)
	else
		return client.supports_method(method, { bufnr = bufnr })
	end
end

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
        --stylua: ignore start
		map("n", "gd", function() Snacks.picker.lsp_definitions({ on_show = function() vim.cmd.stopinsert() end, layout = "ivy", }) end, { desc = "Go to Definition" })
		map("n", "gr", function() Snacks.picker.lsp_references({ on_show = function() vim.cmd.stopinsert() end, layout = "ivy", }) end, { desc = "Go to References" }) -- map("n", "gr", "<CMD>Trouble lsp_references toggle<CR>", { desc = "Go to References" })
		map("n", "gi", function() Snacks.picker.lsp_implementations({ on_show = function() vim.cmd.stopinsert() end, layout = "ivy", }) end, { desc = "Go to References" }) -- map("n", "gr", "<CMD>Trouble lsp_references toggle<CR>", { desc = "Go to References" })
		map("n", "go", "<CMD>Trouble symbols toggle win.position=right<CR>", { desc = "Outline Symbols" })
		map("n", "gn", function() vim.lsp.buf.rename() end, { desc = "Rename" })
		map("n", "ga", function() vim.lsp.buf.code_action() end, { desc = "Code Action" })
		map("n", "gw", "<CMD>Trouble diagnostics toggle<CR>", { desc = "Show Workspace Diagnostics" })
		map("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover Documentation" })
		map("n", "gk", function() vim.diagnostic.open_float() end, { desc = "Previous Diagnostic" })
    map("n", "gK", function() local new_config = not vim.diagnostic.config().virtual_lines vim.diagnostic.config({ virtual_lines = new_config }) end, { desc = "Toggle diagnostic virtual_lines" })
		map("n", "gI", function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled()) end, { desc = "Toggle Inlay Hint" })
		map("n", "gH", function() vim.cmd("checkhealth vim.lsp") end, { desc = "Toggle Inlay Hint" })
		map("n", "gR", function() vim.lsp.stop_client(vim.lsp.get_clients()) vim.defer_fn(function() vim.cmd("edit") end, 2000) end, { desc = "Lsp Restart" })
		-- ctrl + s is default to vim.lsp.buf.signature_help()
		--stylua: ignore end

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
				PATH = "prepend", -- not working when nix "prepend", "append","skip"
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
	-- { -- Main LSP configuration
	-- 	"neovim/nvim-lspconfig",
	-- 	event = { "BufReadPre", "BufNewFile" },
	-- 	dependencies = {
	-- 		-- {
	-- 		-- 	"glepnir/lspsaga.nvim",
	-- 		-- 	event = "LspAttach",
	-- 		-- 	dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
	-- 		-- 	opts = require("settings.lspsaga"),
	-- 		-- },
	-- 		{
	-- 			"folke/trouble.nvim",
	-- 			dependencies = {
	-- 				{ "nvim-tree/nvim-web-devicons" },
	-- 			},
	-- 			cmd = { "Trouble", "TroubleToggle" },
	-- 			opts = {},
	-- 		},
	-- 	},
	-- 	config = require("settings.lspconfig"),
	-- },
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
			formatters_by_ft = G.formatter_services,
		},
	},
	{ -- Autolint
		"mfussenegger/nvim-lint",
		opts = {
			events = { "BufWritePost", "BufReadPost", "InsertLeave" },
		},
		config = function(_, opts)
			require("lint").linters_by_ft = G.linting_services
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
}

return function()
	vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
		if not require("noice.lsp").scroll(4) then
			return "<c-f>"
		end
	end, { silent = true, expr = true })

	vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
		if not require("noice.lsp").scroll(-4) then
			return "<c-b>"
		end
	end, { silent = true, expr = true })

	require("noice").setup({
		lsp = {
			progress = {
				enabled = false, -- use Snacks.nvim notifier instead
				format = {
					{ "{spinner} ", hl_group = "NoiceLspProgressSpinner" },
					{ "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
					{ "{data.progress.message} ", hl_group = "NoiceLspProgressClient" },
				},
				format_done = {
					{ "✔ ", hl_group = "NoiceLspProgressSpinner" },
					{ "{data.progress.title} ", hl_group = "NoiceLspProgressTitle" },
					{ "{data.progress.message} ", hl_group = "NoiceLspProgressClient" },
				},
				throttle = 1000 / 60, -- frequency to update lsp progress message
				view = "mini",
			},
			override = {
				-- override the default lsp markdown formatter with Noice
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				-- override the lsp markdown formatter with Noice
				["vim.lsp.util.stylize_markdown"] = true,
				-- override cmp documentation with Noice (needs the other options to work)
				["cmp.entry.get_documentation"] = true,
			},
			hover = {
				enabled = true,
				view = nil, -- when nil, use defaults from documentation
				opts = {}, -- merged with defaults from documentation
			},
			signature = { -- parameter hint
				enabled = true,
				auto_open = {
					enabled = false,
					trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
					luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
					throttle = 50, -- Debounce lsp signature help request by 50ms
				},
				view = nil, -- when nil, use defaults from documentation
				opts = {}, -- merged with defaults from documentation
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
		views = {
			popup = {
				win_options = {
					winblend = 0,
				},
			},
			mini = {
				position = {
					row = -2,
					col = "100%",
				},
				border = { style = "rounded" },
				win_options = { winblend = 0 },
				size = "auto",
			},
		},
	})
end

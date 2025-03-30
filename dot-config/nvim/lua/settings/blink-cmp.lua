return function()
	local config = require("core.globals")
	local blink = require("blink.cmp")
	blink.setup({
		signature = { enabled = true }, -- use noice.nvim instead
		completion = {
			keyword = { range = "full" },
			accept = { auto_brackets = { enabled = true } },
			list = { selection = { preselect = true, auto_insert = true } },
			menu = {
				auto_show = true,
				border = config.cmp_window_border,
				draw = {
					columns = { { "kind_icon" }, { "label", "source_id", gap = 1 } },
					components = {
						label = {
							text = function(ctx)
								return require("colorful-menu").blink_components_text(ctx)
							end,
							highlight = function(ctx)
								return require("colorful-menu").blink_components_highlight(ctx)
							end,
						},
					},
					treesitter = { "lsp" },
				},
			},
			documentation = {
				window = {
					border = config.cmp_window_border,
				},
				auto_show = true,
				auto_show_delay_ms = 100,
			},
			ghost_text = { enabled = false }, -- conflict with menu auto show
		},
		cmdline = {
			enabled = true,
			keymap = {
				preset = "inherit",
				["<Tab>"] = { "show", "accept" },
			},
			completion = { menu = { auto_show = true } },
		},
		sources = {
			default = { "copilot", "lazydev", "lsp", "path", "snippets", "buffer" },
			providers = {
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					score_offset = 100,
				},
				copilot = {
					name = "copilot",
					module = "blink-copilot",
					score_offset = 100,
					async = true,
				},
			},
		},
		keymap = {
			preset = "none",

			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-p>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },
			["<C-n>"] = { "show_signature", "hide_signature", "fallback" },

			["<Tab>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = { "snippet_backward", "fallback" },
		},

		appearance = {
			nerd_font_variant = "mono",
		},
	})
end

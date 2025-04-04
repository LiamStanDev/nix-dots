-- whether to enable blink-cmp
local function is_cmp_buffer()
	local cmp_dap = require("cmp_dap")
	return vim.bo.buftype ~= "prompt" or cmp_dap.is_dap_buffer()
end

return function()
	local G = require("core")
	local blink = require("blink.cmp")
	blink.setup({
		enabled = is_cmp_buffer,
		signature = { enabled = true }, -- this is show when insert but use noice.nvim not.
		completion = {
			keyword = { range = "full" },
			accept = { auto_brackets = { enabled = true } },
			list = { selection = { preselect = true, auto_insert = true } },
			menu = {
				auto_show = true,
				border = G.cmp_window_border,
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
					border = G.cmp_window_border,
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
			default = function(_)
				local cmp_dap = require("cmp_dap")
				local sql_filetypes = { mysql = true, sql = true }
				if sql_filetypes[vim.bo.filetype] ~= nil then
					return { "dadbod", "snippets", "buffer" }
				elseif cmp_dap.is_dap_buffer() then
					return { "dap", "snippets", "buffer" }
				else
					return { "copilot", "lazydev", "lsp", "path", "snippets", "buffer" }
				end
			end,
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
				dap = { name = "dap", module = "blink.compat.source" },
				dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
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

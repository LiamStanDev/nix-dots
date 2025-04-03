local M = {}

local function cmdline_mapping()
	local cmp = require("cmp")
	return cmp.mapping.preset.cmdline({
		["<TAB>"] = {
			c = function(fallback)
				if cmp.visible() then
					cmp.confirm({ select = true })
				else
					fallback()
				end
			end,
		},
		["<C-j>"] = {
			c = function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				else
					fallback()
				end
			end,
		},
		["<C-k>"] = {
			c = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				else
					fallback()
				end
			end,
		},
	})
end

local function insert_mapping()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	return cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete({}),
		["<C-c>"] = cmp.mapping.abort(),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({ select = true })
			else
				fallback()
			end
		end, { "i", "s" }),
		["<C-l>"] = cmp.mapping(function()
			if luasnip.expand_or_locally_jumpable() then
				luasnip.expand_or_jump()
			end
		end, { "i", "s" }),
		["<C-h>"] = cmp.mapping(function()
			if luasnip.locally_jumpable(-1) then
				luasnip.jump(-1)
			end
		end, { "i", "s" }),
	})
end

function M.config()
	local cmp = require("cmp")
	local utils = require("utils.cmp")

	cmp.setup({
		active = true,
		snippet = {
			expand = function(args)
				require("luasnip").lsp_expand(args.body)
			end,
		},
		-- preselect = cmp.PreselectMode.None,
		mapping = insert_mapping(),
		formatting = {
			fields = { "kind", "abbr", "menu" },
			format = utils.format_colorful,
		},
		sources = {
			{ name = "lazydev", group_index = 0 }, -- nvim configuration
			{ name = "nvim_lsp", group_index = 2 },
			-- { name = "nvim_lsp_signature_help" },
			{ name = "copilot", group_index = 2 },
			{ name = "path" },
			{ name = "luasnip", group_index = 2 },
			{ name = "buffer", group_index = 3 },
			{ name = "nvim_lua", group_index = 3 },
			{ name = "render-markdown", group_index = 2 },
		},
		confirm_opts = {
			select = false,
		},
		window = {
			completion = utils.window_setup().completion,
			documentation = utils.window_setup().documentation,
		},
		sorting = {
			comparators = {
				require("copilot_cmp.comparators").prioritize,
				cmp.config.compare.offset,
				cmp.config.compare.scopes,
				cmp.config.compare.exact,
				cmp.config.compare.score,
				cmp.config.compare.recently_used,
				cmp.config.compare.locality,
				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,

				-- old
				-- cmp.config.compare.offset,
				-- cmp.config.compare.exact,
				-- cmp.config.compare.score,
				-- cmp.config.compare.recently_used,
				-- cmp.config.compare.kind,
			},
		},
	})

	cmp.setup({
		enabled = function()
			return vim.bo.buftype ~= "prompt" or require("cmp_dap").is_dap_buffer()
		end,
	})

	cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
		sources = {
			{ name = "dap" },
		},
	})

	cmp.setup.cmdline("/", {
		mapping = cmdline_mapping(),
		sources = {
			{ name = "buffer" },
		},
	})

	cmp.setup.cmdline(":", {
		mapping = cmdline_mapping(),
		sources = cmp.config.sources({
			{ name = "cmdline" },
			{ name = "path" },
		}),
	})
	cmp.setup.cmdline("@", {
		mapping = cmdline_mapping(),
		sources = cmp.config.sources({
			{ name = "cmdline-prompt" },
			{ name = "path" },
		}),
	})
end

return M

local M = {}
function M.window_setup()
	local G = require("core.globals")
	if G.cmp_window_border == "rounded" then
		local border_opt = {
			border = "rounded", -- single, rounded
			winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
			col_offset = -3,
			side_padding = 0,
		}
		return {
			completion = require("cmp.config.window").bordered(border_opt),
			documentation = require("cmp.config.window").bordered(border_opt),
		}
	end
	if G.cmp_window_border == "single" then
		local border_opt = {
			border = "single", -- single, rounded
			winhighlight = "Normal:Normal,FloatBorder:FloatBorder,CursorLine:Visual,Search:None",
		}
		return {
			completion = require("cmp.config.window").bordered(border_opt),
			documentation = require("cmp.config.window").bordered(border_opt),
		}
	end
	return {
		completion = require("cmp.config.window"),
		documentation = require("cmp.config.window"),
	}
end

function M.format_colorful(entry, item)
	local lspkind = require("lspkind").cmp_format({
		mode = "symbol_text",
		maxwidth = {
			abbr = 30,
			menu = 40,
		},
		ellipsis_char = "...",
		show_labelDetails = true,
		symbol_map = { -- add more icon
			Copilot = "",
		},
	})(entry, item)
	local strings = vim.split(lspkind.kind, "%s", { trimempty = true })
	-- print(vim.inspect(strings))
	-- print(vim.inspect(item.menu))
	item.kind = " " .. (strings[1] or "") .. " "
	item.menu = item.menu

	return item
end
return M

local utils = require("settings.lualine.utils")

-- setup component
local component = {
	spaces = {
		function()
			return " "
		end,
		padding = 0.3,
	},

	indent = {
		function()
			return "" .. vim.bo.shiftwidth
		end,
	},
}
return component

local utils = require("config.lualine.utils")

-- setup component
local component = {
	spaces = {
		function()
			return " "
		end,
		padding = 0.3,
	},
}
return component

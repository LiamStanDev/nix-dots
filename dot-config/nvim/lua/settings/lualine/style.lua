local components = require("settings.lualine.components")

local M = {
	options = {
		icons_enabled = true,
		globalstatus = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = {
			statusline = { "snacks_dashboard" },
		},
		always_divide_middle = true,
	},
	sections = {
		lualine_a = {
			components.mode,
		},
		lualine_b = {
			components.spaces,
			components.python_env,
			{
				"filetype",
				icon_only = true,
				colored = true,
				padding = -1,
				color = { bg = "#2a2c3f", fg = "#BDCBD6" },
				separator = { left = "", right = " " },
			},
			{
				"filename",
				file_status = true,
				padding = 0,
				separator = { left = "", right = " " },
				symbols = {
					modified = "",
					readonly = "",
				},
				color = { bg = "#2a2c3f", fg = "#BDCBD6" },
			},
		},
		lualine_c = {
			components.spaces,
			components.branch,
			components.diff,
		},
		lualine_x = {
			components.diagnostics,
			components.lsp,
			{
				function()
					return "󱞩"
				end,
				separator = { left = "", right = "" },
				color = { bg = "#8FBCBB", fg = "#000000" },
				padding = 0.3,
			},
			components.indent,
			{
				function()
					return ""
				end,
				separator = { left = "", right = "" },
				color = { bg = "#ECD3A0", fg = "#000000" },
				padding = 0.3,
			},
			{
				"filetype",
				icon_only = false,
				colored = true,
				padding = 1,
				-- color = { bg = "#2a2c3f", fg = "#BDCBD6" },
			},
			{
				function()
					return ""
				end,
				separator = { left = "", right = "" },
				color = { bg = "#86AAEC", fg = "#000000" },
				padding = 0.3,
			},
			{
				"progress",
				-- color = { bg = "#2a2c3f", fg = "#BDCBD6" },
			},
		},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = {},
}

return M

return function()
	local components = require("config.lualine.components")
	local utils = require("config.lualine.utils")
	local palette = require("catppuccin.palettes").get_palette("frappe")
	local statusline = require("arrow.statusline")

	require("lualine").setup({
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
				{
					"mode",
					fmt = function()
						return ""
					end,
					separator = {
						left = "",
						-- right = " "
					},
					padding = {
						left = 1,
						right = 2,
					},
				},
			},
			lualine_b = {
				{
					"filetype",
					icon_only = true,
					colored = true,
					padding = { left = 2, right = -1 },
					color = { bg = palette.mantle, fg = palette.text },
				},
				{
					"filename",
					file_status = true,
					padding = { right = 2 },
					-- show directory name
					-- path = 1,
					separator = { left = "", right = "" },
					symbols = { modified = "", readonly = "" },
					color = { bg = palette.mantle, fg = palette.text },
					cond = utils.buffer_not_empty,
				},
				{
					-- python env
					function()
						if vim.api.nvim_get_option_value("filetype", { buf = 0 }) == "python" then
							local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
							if venv then
								return string.format("(%s)", utils.env_cleanup(venv))
							end
						end
						return ""
					end,
					separator = { right = "" },
					color = { fg = palette.yellow, bg = palette.mantle },
					padding = { left = 0, right = 1 },
				},
				components.spaces,
				{
					"branch",
					icon = "",
					separator = { left = "", right = "" },
					padding = 1,
					color = { bg = palette.mantle, fg = palette.rosewater },
				},
				{
					"diff",
					colored = true,
					symbols = { added = " ", modified = " ", removed = " " },
					separator = { left = "", right = "" },
					color = { bg = palette.mantle },
				},
				components.spaces,
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "hint" },
					symbols = { error = " ", warn = " ", hint = " ", info = " " },
					colored = true,
					padding = { left = 1, right = 1 },
				},
			},
			lualine_c = {
				{ -- center
					function()
						return "%="
					end,
				},
				{
					function()
						return os.date("%H:%M")
					end,
					icon = "",
					padding = { left = 1, right = 1 },
					color = { fg = palette.blue },
				},
			},
			lualine_x = {
				{
					utils.mason_updates() .. "",
					color = { fg = palette.maroon },
					cond = function()
						return utils.mason_updates() > 0
					end,
					icon = "",
					on_click = function()
						vim.cmd("Mason")
					end,
				},
				{
					require("lazy.status").updates,
					cond = require("lazy.status").has_updates,
					color = { fg = palette.subtext0 },
					padding = { left = 1, right = 2 },
					separator = { right = "" },
				},
				{
					-- arrow nvim
					function()
						return statusline.text_for_statusline_with_icons()
					end,
					color = { fg = palette.green },
					padding = { left = 0, right = 2 },
				},
				{
					-- copilot
					utils.copilot_status_icon,
					padding = { left = 0, right = 2 },
					separator = { right = "" },
					color = { fg = palette.flamingo },
				},
				{
					-- lsp
					function()
						local default_msg = "No LSP"

						local clients = vim.lsp.get_clients({ bufnr = 0 })
						if next(clients) == nil then
							return default_msg
						end

						local client_names = {}
						for _, client in ipairs(clients) do
							if client.name ~= "copilot" then
								table.insert(client_names, client.name)
							end
						end

						local text_client = table.concat(client_names, ", ")
						if text_client == "" then
							return default_msg
						end
						return text_client
					end,
					icon = " ",
					color = { fg = palette.yellow },
					padding = { left = 0, right = 2 },
				},
				{
					"encoding",
					color = { fg = palette.pink },
					padding = { left = 0, right = 2 },
				},
				{
					"fileformat",
					color = { fg = palette.blue },
					padding = { left = 0, right = 2 },
				},
				{
					function()
						return "󱞩 "
					end,
					separator = {
						left = "",
					},
					color = { bg = "#8FBCBB", fg = "#000000" },
					padding = 0.3,
				},
				{
					function()
						return "" .. vim.bo.shiftwidth
					end,
					padding = { left = 1, right = 0.5 },
					separator = {
						right = "",
					},
					color = { bg = palette.mantle, fg = palette.text },
				},
				components.spaces,
				{
					function()
						return " "
					end,
					separator = {
						left = "",
					},
					color = { bg = "#ECD3A0", fg = "#000000" },
					padding = 0.3,
				},
				{
					"filetype",
					icon_only = false,
					colored = true,
					padding = { left = 1, right = 0.5 },
					separator = {
						right = "",
					},
					color = { bg = palette.mantle, fg = palette.text },
				},
				components.spaces,
				{
					function()
						return " "
					end,
					separator = {
						left = "",
					},
					color = { bg = "#86AAEC", fg = "#000000" },
					padding = 0.3,
				},
				{
					"progress",
					separator = {
						right = "",
					},
					color = { bg = palette.mantle, fg = palette.text },
					padding = { left = 1, right = 0.5 },
				},
			},
			lualine_y = {},
			lualine_z = {},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	})
end

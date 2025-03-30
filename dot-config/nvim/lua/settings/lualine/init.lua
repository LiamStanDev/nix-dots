return function()
	local components = require("settings.lualine.components")
	local utils = require("settings.lualine.utils")
	local palette = require("catppuccin.palettes").get_palette("frappe")

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
					separator = { left = "", right = " " },
					padding = { left = 1, right = 1 },
				},
			},
			lualine_b = {
				components.spaces,
				{
					"filetype",
					icon_only = true,
					colored = true,
					padding = -1,
					color = { bg = "#2a2c3f", fg = palette.text },
					separator = { left = "", right = "" },
				},
				{
					"filename",
					file_status = true,
					padding = 0,
					separator = { left = "", right = "" },
					symbols = {
						modified = "",
						readonly = "",
					},
					color = { bg = "#2a2c3f", fg = palette.text },
					cond = utils.buffer_not_empty,
				},
				components.spaces,
				{
					-- python env
					function()
						if vim.api.nvim_get_option_value("filetype", { buf = 0 }) == "python" then
							local venv = os.getenv("CONDA_DEFAULT_ENV") or os.getenv("VIRTUAL_ENV")
							if venv then
								local icons = require("nvim-web-devicons")
								local py_icon, _ = icons.get_icon(".py")
								return string.format(" " .. py_icon .. " (%s)", utils.env_cleanup(venv))
							end
						end
						return ""
					end,
					color = { fg = palette.yellow },
					padding = 1,
				},
				components.spaces,
				{
					"branch",
					icon = "",
					separator = { left = "", right = "" },
					-- padding = 1,
					color = { bg = "#2a2c3f", fg = palette.text },
				},
				{
					"diff",
					colored = true,
					symbols = {
						added = " ",
						modified = " ",
						removed = " ",
					},
					separator = { left = "", right = "" },
					color = { bg = "#2a2c3f" },
				},
				components.spaces,
				{
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
					-- color = { fg = palette.blue },
				},
			},
			lualine_c = {},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = {
						"error",
						"warn",
						"hint",
					},
					symbols = {
						error = " ",
						warn = " ",
						hint = " ",
						info = " ",
					},
					colored = true,
					padding = { left = 1, right = 1 },
				},
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
					padding = { left = 1, right = 2 },
					separator = { right = "" },
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
					-- color = { bg = "#2a2c3f", fg = "#BDCBD6" },
					color = { fg = palette.yellow },
					-- separator = { left = "", right = " " },
					padding = { left = 0, right = 2 },
					-- separator = { right = "", left = "" },
				},
				{
					"encoding",
					color = { fg = palette.pink },
					padding = { left = 0, right = 2 },
				},
				{
					"fileformat",
					color = { fg = palette.cyan },
					padding = { left = 0, right = 2 },
				},
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
						return "  "
					end,
					separator = { left = "", right = "" },
					color = { bg = "#86AAEC", fg = "#000000" },
					padding = 0.3,
				},
				-- {
				-- 	"progress",
				-- 	-- color = { bg = "#2a2c3f", fg = "#BDCBD6" },
				-- },
				{
					"progress",
					padding = { left = 1, right = 1 },
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

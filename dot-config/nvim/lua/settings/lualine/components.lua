local utils = require("settings.lualine.utils")

-- setup component
local component = {
	python_env = {
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
		color = { bg = "#2a2c3f", fg = "#dbcd0b" },

		separator = { left = "", right = " " },
	},
	lsp = {
		function()
			local buf_ft = vim.bo.filetype

			local clients = vim.lsp.get_clients({ bufnr = 0 })
			if not clients or vim.tbl_isempty(clients) then
				return "Inactive"
			end

			local client_names = {}

			for _, client in ipairs(clients) do
				table.insert(client_names, client.name)
			end

			local msg = ""
			if #client_names > 0 then
				msg = " " .. table.concat(client_names, ", ")
			end
			if msg == "" then
				msg = "Inactive"
			end
			return msg
		end,
		-- icon = "",
		color = { gui = "bold" },
	},

	hide_in_width = {
		function()
			return vim.fn.winwidth(0) > 80
		end,
	},

	spaces = {
		function()
			return " "
		end,
		padding = 0.3,
	},

	diagnostics = {
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
		always_visible = false,
	},

	branch = {
		"branch",
		icon = "",
		separator = { left = "", right = "" },
		padding = 1,
		color = { bg = "#2a2c3f", fg = "#BDCBD6" },
	},

	diff = {
		"diff",
		colored = true,
		symbols = {
			added = " ",
			modified = " ",
			removed = " ",
		},
		color = { bg = "#2a2c3f" },
		separator = { left = "", right = "" },
	},

	filetype = {
		"filetype",
		icons_enabled = true,
	},

	location = {
		"location",
	},

	custom_icons = {
		function()
			-- return ""
			-- return ""
			return ""
		end,
		separator = { left = "", right = "" },
	},

	modes = {
		"mode",
		separator = { left = "", right = "" },
		padding = 0.8,
	},

	indent = {
		function()
			return "" .. vim.api.nvim_buf_get_option(0, "shiftwidth")
		end,
	},
}
return component

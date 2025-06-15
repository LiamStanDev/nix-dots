local palette = require("core.palette")
return {
	signs = true, -- show icons in the signs column
	sign_priority = 8, -- sign priority
	keywords = {
		FIX = {
			icon = " ", -- icon used for the sign, and in search results
			color = "error", -- can be a hex color, or a named color (see below)
			alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
			-- signs = false, -- configure signs for some keywords individually
		},
		-- TODO:
		-- HACK:
		-- WARN:
		-- PERF:
		-- NOTE:
		-- TEST:
		-- FIXME:
		TODO = { icon = " ", color = "info" },
		HACK = { icon = " ", color = "warning" },
		WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
		PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
		NOTE = { icon = " ", color = "#9399b2", alt = { "INFO" } },
		TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
	},

	highlight = {
		multiline = false, -- enable multine todo comments
		after = "", -- only hightlight keyword
	},
	colors = {
		error = { "DiagnosticError", "ErrorMsg", palette.red },
		warning = { "DiagnosticWarn", "WarningMsg", palette.yellow },
		info = { "DiagnosticInfo", palette.lavender },
		hint = { "DiagnosticHint", palette.lavender },
		default = { "Identifier", palette.mauve },
		test = { "Identifier", palette.flamingo },
	},
}

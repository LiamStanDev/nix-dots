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
		error = { "DiagnosticError", "ErrorMsg", "#F28FAD" },
		warning = { "DiagnosticWarn", "WarningMsg", "#FAE3B0" },
		info = { "DiagnosticInfo", "#96CDFB" },
		hint = { "DiagnosticHint", "#9399b2" },
		default = { "Identifier", "#DDB6F2" },
		test = { "Identifier", "#F5C2E7" },
	},
}

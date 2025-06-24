return function()
	require("trouble").setup({
		focus = true,
		auto_preview = true,
		auto_refresh = true, -- auto refresh when open
		pinned = false, -- When pinned, the opened trouble window will be bound to the current buffer

		-- global preview config
		preview = {
			type = "main",
			scratch = true,
		},
	})
end

return function()
	local luasnip = require("luasnip")
	luasnip.setup({
		history = true,
		updateevents = "TextChanged,TextChangedI",
		delete_check_events = "TextChanged,InsertLeave",
	})

	-- let one file can use multiple snippet sources.
	luasnip.filetype_extend("typescriptreact", { "html" })
	luasnip.filetype_extend("javascriptreact", { "html" })

	require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/" } })
end

local map = vim.keymap.set
map({ "n", "v", "i", "t" }, "<A-`>", function()
	Snacks.terminal()
end, { desc = "Terminal" })

return {}

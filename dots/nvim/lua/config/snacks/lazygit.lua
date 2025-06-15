local map = vim.keymap.set

map("n", "<leader>gg", function()
	Snacks.lazygit()
end, { desc = "Lazygit" })

return {
	configure = true, -- use current colorscheme
	win = {
		style = "lazygit",
	},
}

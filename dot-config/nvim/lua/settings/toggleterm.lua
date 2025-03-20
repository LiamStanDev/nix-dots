return function()
	require("toggleterm").setup({
		size = 20,
		direction = "horizontal", -- horizontal: bottom, vertical: right, tab
		open_mapping = "<C-S>",
		float_opts = {
			border = "curved",
			winblend = 0,
			-- highlights = {
			-- 	border = "Normal",
			-- 	background = "Normal",
			-- },
		},
	})

	-- terminal window mappings
	function _G.set_terminal_keymaps()
		local opts = { noremap = true }
		vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
		-- the following keybindings make the lazygit move very lagging
		vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "kj", [[<C-\><C-n>]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
		vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
	end

	vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	local Terminal = require("toggleterm.terminal").Terminal
	local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

	function _LAZYGIT_TOGGLE()
		lazygit:toggle()
	end

	vim.api.nvim_create_user_command("Lazygit", _LAZYGIT_TOGGLE, {})

	local keymap = vim.keymap.set
	keymap({ "n", "i", "v", "t" }, "<A-`>", "<CMD>ToggleTerm<CR>")
end

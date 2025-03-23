local map = vim.keymap.set

vim.api.nvim_create_user_command("ShowTasks", function()
	require("utils.task").open_task_menu()
end, { nargs = 0 })

-- Top Pickers & Explorer
-- stylua: ignore start
-- expolorer
map("n", "<leader>e", function() Snacks.picker.explorer({ hidden = true, ignored = true }) end, { desc = "Explorer" })

-- task runner
map({ "n", "i", "v", "t" }, "<A-]>", "<CMD>ShowTasks<CR>")

-- git
map("n", "<leader>gb", function() Snacks.picker.git_branches() end, { desc = "Git Branches" })
map("n", "<leader>gl", function() Snacks.picker.git_log() end, { desc = "Git Log" })
map("n", "<leader>gS", function() Snacks.picker.git_stash() end, { desc = "Git Stash" })

-- search
map("n", "<leader>p", function() Snacks.picker.files({ hidden = true }) end, { desc = "Smart Find Files" })
map("n", "<leader>sb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>sg", function() Snacks.picker.grep({ hidden = true }) end, { desc = "Grep" })
map("n", "<leader>s:", function() Snacks.picker.command_history() end, { desc = "Command History" })
map("n", "<leader>sn", function() Snacks.picker.notifications() end, { desc = "Notification History" })
map("n", "<leader>sp", function() Snacks.picker.projects() end, { desc = "Projects" })
map("n", "<leader>sr", function() Snacks.picker.recent() end, { desc = "Recent" })
map("n", '<leader>s/', function() Snacks.picker.search_history() end, { desc = "Search History" })
map("n", "<leader>sq", function() Snacks.picker.qflist() end, { desc = "Quickfix List" })
map("n", "<leader>sC", function() Snacks.picker.colorschemes() end, { desc = "Colorschemes" })

-- LSP
-- map("n", "gd",  function() Snacks.picker.lsp_definitions() end, { desc = "Goto Definition" })
-- -- map("n", "gD",  function() Snacks.picker.lsp_declarations() end, { desc = "Goto Declaration" })
-- map("n", "gr",  function() Snacks.picker.lsp_references() end, { nowait = true, desc = "References" })
-- map("n", "gi",  function() Snacks.picker.lsp_implementations() end, { desc = "Goto Implementation" })
-- -- map("n", "gy",  function() Snacks.picker.lsp_type_definitions() end, { desc = "Goto T[y]pe Definition" })
-- map("n", "go", function() Snacks.picker.lsp_symbols() end, { desc = "LSP Symbols" })
-- map("n", "<leader>gO", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "LSP Workspace Symbols" })
-- stylua: ignore end

return {
	enabled = true,
	prompt = "   ",
}

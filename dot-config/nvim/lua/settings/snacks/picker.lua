local map = vim.keymap.set

vim.api.nvim_create_user_command("ShowTasks", function()
	require("utils.task").open_task_menu()
end, { nargs = 0 })

-- NOTE: layout has following options: vertical, ivy, ivy_split,
-- dropdown, select, default, sidebar, vscode.

-- Top Pickers & Explorer
-- expolorer
map("n", "<leader>e", function()
	Snacks.picker.explorer({ hidden = true, ignored = true })
end, { desc = "Explorer" })

-- task runner
map({ "n", "i", "v", "t" }, "<A-]>", "<CMD>ShowTasks<CR>")

-- git
map("n", "<leader>gb", function()
	Snacks.picker.git_branches({
		layout = "select",
	})
end, { desc = "Git Branches" })
map("n", "<leader>gl", function()
	Snacks.picker.git_log({
		finder = "git_log",
		format = "git_log",
		preview = "git_show",
		checkout = "git_checkout",
		layout = "vertical",
	})
end, { desc = "Git Log" })
map("n", "<leader>gS", function()
	Snacks.picker.git_stash()
end, { desc = "Git Stash" })

-- search
map("n", "<leader>p", function()
	Snacks.picker.files({
		finder = "files",
		format = "file",
		show_empty = tue,
		support_live = true,
		hidden = true,
		layout = "select",
	})
end, { desc = "Smart Find Files" })

map("n", "<leader>bl", function()
	Snacks.picker.buffers({
		-- start in normal mode
		on_show = function()
			vim.cmd.stopinsert()
		end,
		finder = "buffers",
		format = "buffer",
		hidden = false,
		unloaded = true,
		current = true,
		sort_lastused = true,
		win = {
			input = { keys = { ["d"] = "bufdelete" } },
			list = { keys = { ["d"] = "bufdelete" } },
		},
		layout = "ivy",
	})
end, { desc = "Buffers" })
map("n", "<leader>sg", function()
	Snacks.picker.grep({
		hidden = true,
		regex = true,
		live = true,
		dirs = { vim.fn.getcwd() },
		args = { "--no-ignore" },
		finder = "grep",
		format = "file",
		show_empty = true,
		layout = "ivy",
	})
end, { desc = "Grep" })
-- map("n", "<leader>s:", function()
-- 	Snacks.picker.command_history()
-- end, { desc = "Command History" })
map("n", "<leader>sn", function()
	Snacks.picker.notifications({
		on_show = function()
			vim.cmd.stopinsert()
		end,
		layout = "ivy",
	})
end, { desc = "Notification History" })
-- map("n", "<leader>sp", function()
-- 	Snacks.picker.projects()
-- end, { desc = "Projects" })
-- map("n", "<leader>sr", function()
-- 	Snacks.picker.recent()
-- end, { desc = "Recent" })
-- map("n", "<leader>s/", function()
-- 	Snacks.picker.search_history()
-- end, { desc = "Search History" })
-- map("n", "<leader>sq", function()
-- 	Snacks.picker.qflist()
-- end, { desc = "Quickfix List" })

map("n", "<leader>sC", function()
	Snacks.picker.colorschemes()
end, { desc = "Colorschemes" })

return {
	enabled = true,
	prompt = "   ",
	layout = { cycle = false, preset = "ivy" },
}

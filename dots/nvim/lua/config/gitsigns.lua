return function()
	local gs = require("gitsigns")
	gs.setup({
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untrack = { text = "┆" },
		},

		signs_staged = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "_" },
			untracked = { text = "┆" },
		},
	})

	local map = vim.keymap.set


	-- stylua: ignore start
	map("n", "]h", function() gs.nav_hunk("last") end, { desc = "Last Hunk" })
	map("n", "[h", function() gs.nav_hunk("first") end,{ desc = "First Hunk" })
	map({ "n", "v" }, "<leader>ghs", gs.stage_hunk, { desc = "Git stage hunk" })
	map({ "n", "v" }, "<leader>ghr", gs.reset_hunk, { desc = "Git reset hunk" })
	map("n", "<leader>ghS", gs.stage_buffer, { desc = "Git stage buffer" })
	map("n", "<leader>ghR", gs.reset_buffer, { desc = "git reset buffer" })
  map("n", "<leader>ghl", function() gs.blame_line({ full = true }) end, { desc = "Git blame line" })
  map("n", "<leader>ghb", function() gs.blame() end, { desc = "Git blame buffer" })
	map("n", "<leader>ghp", gs.preview_hunk, { desc = "git preview hunk" })
	map("n", "<leader>ghd", function() gs.diffthis("~") end, { desc = "Git diff against last commit" })
	-- stylua: ignore end
end

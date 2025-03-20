return function()
	local gitsigns = require("gitsigns")
	gitsigns.setup({
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

	map("n", "gj", function()
		gitsigns.nav_hunk("next")
	end, { desc = "Jump to next git change" })
	map("n", "gk", function()
		gitsigns.nav_hunk("prev")
	end, { desc = "Jump to previous git [c]hange" })

	-- normal mode
	map({ "n", "v" }, "<leader>gs", gitsigns.stage_hunk, { desc = "Git stage hunk" })
	map({ "n", "v" }, "<leader>gr", gitsigns.reset_hunk, { desc = "Git reset hunk" })

	map({ "n", "v" }, "<leader>gu", gitsigns.stage_hunk, { desc = "Git undo hunk" })
	map("n", "<leader>gS", gitsigns.stage_buffer, { desc = "Git stage buffer" })
	map("n", "<leader>gR", gitsigns.reset_buffer, { desc = "git reset buffer" })
	map("n", "<leader>gp", gitsigns.preview_hunk, { desc = "git preview hunk" })
	map("n", "<leader>gl", gitsigns.blame_line, { desc = "Git blame line" })
	map("n", "<leader>gd", gitsigns.diffthis, { desc = "Git diff against index" })
	map("n", "<leader>gD", function()
		gitsigns.diffthis("@")
	end, { desc = "Git diff against last commit" })
end

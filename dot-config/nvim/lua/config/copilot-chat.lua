return function()
	require("CopilotChat").setup({
		window = {
			layout = "horizontal", -- 'vertical', 'horizontal', 'float', 'replace'
			width = 0.5, -- fractional width of parent, or absolute width in columns when > 1
			height = 0.3, -- fractional height of parent, or absolute height in rows when > 1
		},
		model = "o3-mini",
		sticky = {
			"#files",
			-- "$o1",
		},

		-- for render markdown
		highlight_headers = false,
		separator = "---",
		error_header = "> [!ERROR] Error",

		-- log_level = "debug",
	})

	-- copilot chat
	local map = vim.keymap.set
	map({ "n", "i", "v", "t" }, "<A-\\>", "<CMD>CopilotChatToggle<CR>", { desc = "Toggle copilot chat" })
	map({ "n", "v" }, "<leader>ad", "<CMD>Copilot disable<CR>", { desc = "Copilot Disable" })
	map({ "n", "v" }, "<leader>ae", "<CMD>Copilot enable<CR>", { desc = "Copilot Enable" })
	map({ "n", "v" }, "<leader>aa", "<CMD>CopilotChatToggle<CR>", { desc = "Toggle Chat" })
	map({ "n", "v" }, "<leader>ae", "<CMD>CopilotChatExplain<CR>", { desc = "Explain this" })
	map({ "n", "v" }, "<leader>ar", "<CMD>CopilotChatReview<CR>", { desc = "Review this" })
	map({ "n", "v" }, "<leader>af", "<CMD>CopilotChatFix<CR>", { desc = "Fix this" })
	map({ "n", "v" }, "<leader>ao", "<CMD>CopilotChatOptimize<CR>", { desc = "Optimize this" })
	map({ "n", "v" }, "<leader>ad", "<CMD>CopilotChatDocs<CR>", { desc = "Generate docs" })
	map({ "n", "v" }, "<leader>at", "<CMD>CopilotChatTests<CR>", { desc = "Generate tests" })
	map({ "n", "v" }, "<leader>aF", "<CMD>CopilotChatFixDiagnostic<CR>", { desc = "Fix diagnostic" })
end

return function()
	local user = vim.env.USER or "User"
	user = user:sub(1, 1):upper() .. user:sub(2)

	vim.api.nvim_create_autocmd("BufEnter", {
		pattern = "copilot-chat",
		callback = function()
			vim.opt_local.relativenumber = false
			vim.opt_local.number = false
		end,
	})

	require("CopilotChat").setup({
		window = {
			layout = "vertical", -- 'vertical', 'horizontal', 'float', 'replace'
			width = 0.35, -- fractional width of parent, or absolute width in columns when > 1
			height = 0.3, -- fractional height of parent, or absolute height in rows when > 1
		},
		model = "o3-mini",
		sticky = {
			"#files",
		},

		show_help = false,
		auto_insert_mode = false,
		highlight_selection = true,

		-- for render markdown
		highlight_headers = false,
		separator = "",
		error_header = "> [!ERROR] Error ",
		question_header = "#   " .. user .. " ",
		answer_header = "#   Copilot ",

		-- log_level = "debug",

		prompts = {
			Explain = {
				prompt = "Write an explanation for the selected code as paragraphs of text.",
				system_prompt = "COPILOT_EXPLAIN",
			},
			Review = {
				prompt = "Review the selected code.",
				system_prompt = "COPILOT_REVIEW",
			},
			Fix = {
				prompt = "There is a problem in this code. Identify the issues and rewrite the code with fixes. Explain what was wrong and how your changes address the problems.",
			},
			Optimize = {
				prompt = "Optimize the selected code to improve performance and readability. Explain your optimization strategy and the benefits of your changes.",
			},
			Docs = {
				prompt = "Please add documentation comments to the selected code.",
			},
			Tests = {
				prompt = "Please generate tests for my code.",
			},
			Commit = {
				prompt = "Write commit message for the change with commitizen convention. Keep the title under 50 characters and wrap message at 72 characters. Format as a gitcommit code block.",
				context = "git:staged",
			},
		},
	})

	local picker = require("utils.picker")
	-- copilot chat
	local map = vim.keymap.set
	map({ "n", "i", "v", "t" }, "<A-\\>", "<CMD>CopilotChatToggle<CR>", { desc = "Toggle Chat" })
	map({ "n", "v" }, "<leader>aa", "<CMD>CopilotChatToggle<CR>", { desc = "Toggle Chat" }) -- NOTE: dont remap to term mode, it will cause term space key lagging
	map({ "n", "v" }, "<leader>ax", function()
		return require("CopilotChat").reset()
	end, { desc = "Clear" })
	map({ "n", "v" }, "<leader>aq", function()
		vim.ui.input({
			prompt = "Quick Chat: ",
		}, function(input)
			if input ~= "" then
				require("CopilotChat").ask(input)
			end
		end)
	end, { desc = "Quick Chet" })

	map({ "n", "v" }, "<leader>ap", "<CMD>CopilotChatPrompts<CR>", { desc = "Prompt Actions" })
	map({ "n", "v" }, "<leader>as", "<CMD>CopilotChatStop<CR>", { desc = "Stop Current Chat" })
	map({ "n", "v" }, "<leader>aS", function()
		vim.cmd("CopilotChatSave " .. vim.fn.strftime("%Y-%m-%d-%H:%M:%S"))
	end, { desc = "Save Chat" })
	map({ "n", "v" }, "<leader>aL", function()
		picker.load_saved_chat()
	end, { desc = "Load Chat" })

	map({ "n", "v" }, "<leader>am", "<CMD>CopilotChatModels<CR>", { desc = "Choose Models" })

	map({ "n", "v" }, "<leader>ae", "<CMD>Copilot enable<CR>", { desc = "Copilot Enable" })
	map({ "n", "v" }, "<leader>ad", "<CMD>Copilot disable<CR>", { desc = "Copilot Disable" })
end

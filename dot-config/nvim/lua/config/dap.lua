local M = {}

function M.init()
	-- sign
	vim.fn.sign_define("DapBreakpoint", {
		text = "", --"",
		texthl = "DiagnosticSignError",
		linehl = "",
		numhl = "",
	})
	vim.fn.sign_define("DapBreakpointRejected", {
		text = "",
		texthl = "DiagnosticSignError",
		linehl = "",
		numhl = "",
	})
	vim.fn.sign_define("DapStopped", {
		text = "",
		texthl = "DiagnosticSignWarn",
		linehl = "Visual",
		numhl = "DiagnosticSignWarn",
	})
end

function M.config()
	local dap = require("dap")
	local dapui = require("dapui")

	require("config.dap-settings.dap-adaptor-setup")
	require("config.dap-settings.dap-lang-setup")

	local map = vim.keymap.set
	map("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
	map("n", "<leader>dl", "<CMD>Telescope dap list_breakpoints<CR>", { desc = "List Breakpoints" })
	map("n", "<leader>dr", dap.continue, { desc = "Start" })
	map("n", "<leader>dc", dap.continue, { desc = "Continue" })
	map("n", "<leader>dq", dap.disconnect, { desc = "Disconnect" })
	map("n", "<leader>ds", dap.step_into, { desc = "Step Into" })
	map("n", "<leader>dn", dap.step_over, { desc = "Step Over" })
	map("n", "<leader>do", dap.step_out, { desc = "Step Out" })
	map("n", "<leader>de", "<CMD>lua require'dap'.eval()<CR>", { desc = "Eval" })
	map("n", "<leader>du", function()
		dapui.toggle({ reset = true })
	end, { desc = "Toggle UI" })
end

return M

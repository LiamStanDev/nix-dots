---@param config {type?:string, args?:string[]|fun():string[]?}
local function get_args(config)
	local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
	local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

	config = vim.deepcopy(config)
	---@cast args string[]
	config.args = function()
		local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
		if config.type and config.type == "java" then
			---@diagnostic disable-next-line: return-type-mismatch
			return new_args
		end
		return require("dap.utils").splitstr(new_args)
	end
	return config
end

return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			{ "theHamsta/nvim-dap-virtual-text", opts = {} },
		},
    -- stylua: ignore
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      -- { "<leader>dr", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
      { "<leader>dr", function() require("dap").continue() end, desc = "Run with Args" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>ds", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dn", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dq", function() require("dap").terminate() require("dapui").close() end, desc = "Terminate" },
      { "<leader>dS", function() require("dap").session() end, desc = "Session" },
    },
		init = function()
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
		end,
		config = function()
			local vscode = require("dap.ext.vscode")
			local json = require("plenary.json")
			vscode.json_decode = function(str)
				return vim.json.decode(json.json_strip_comments(str))
			end

			require("config.dap").setup()
			-- require("config.dap.dap-adaptor-setup")
			-- require("config.dap.dap-lang-setup")
		end,
	},

	{
		"rcarriga/nvim-dap-ui",
		opts = {
			icons = { expanded = "", collapsed = "", circular = "" },
			layouts = {
				{
					elements = {
						{ id = "repl", size = 0.3 },
						{ id = "breapoints", size = 0.2 },
						{ id = "stacks", size = 0.3 },
						{ id = "console", size = 0.2 },
					},
					position = "right",
					size = 50,
				},
				{
					elements = {
						{ id = "scopes", size = 0.5 },
						{ id = "watches", size = 0.5 },
					},
					position = "bottom",
					size = 20,
				},
			},
		},
		config = function(_, opts)
			local dap = require("dap")
			local dapui = require("dapui")
			dapui.setup(opts)
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open({})
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close({})
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close({})
			end
		end,
    -- stylua: ignore
    keys = {
      { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
    },
		dependencies = {
			"nvim-neotest/nvim-nio",
		},
	},
}

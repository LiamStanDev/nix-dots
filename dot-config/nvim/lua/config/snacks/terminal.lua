-- NOTE: If you encounter any terminal space key lagging, please
-- checkt `:verbose inoremap <space>`, `:verbose vnpremap <space>`
-- and `:verbose tnoremap <space>`.

local G = require("core")
local map = vim.keymap.set

-- Usage: toggle term with id is 8 for example
-- press 8 and then presss `<A-`>`
map({ "n", "v", "i", "t" }, "<A-`>", function()
	Snacks.terminal.toggle(nil, {
		win = {
			height = 0.3,
			position = "bottom",
		},
	})
end, { desc = "Terminal" })

local function term_nav(dir)
	---@param self snacks.terminal
	return function(self)
		return self:is_floating() and "<c-" .. dir .. ">" or vim.schedule(function()
			vim.cmd.wincmd(dir)
		end)
	end
end

return {
	win = {
		keys = {
			nav_h = { "<C-h>", term_nav("h"), desc = "Go to Left Window", expr = true, mode = "t" },
			nav_l = { "<C-l>", term_nav("l"), desc = "Go to Right Window", expr = true, mode = "t" },
		},
		border = G.terminal_border,
		bo = { filetype = "snacks_terminal" },
		on_win = function(self)
			local footer_msg = ""
			if self.cmd then
				if type(self.cmd) == "table" then
					footer_msg = "Running command: " .. table.concat(self.cmd, " ")
				else
					footer_msg = "Running command: " .. tostring(self.cmd)
				end
			end
			vim.api.nvim_win_set_config(self.win, { title = footer_msg })
		end,
	},
}

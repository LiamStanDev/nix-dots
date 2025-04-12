local map = vim.keymap.set
map({ "n", "v", "i", "t" }, "<A-`>", function()
	Snacks.terminal(nil, { env = { id = 0 }, win = { position = "bottom" } })
end, { desc = "Terminal" })

map({ "n", "v", "i", "t" }, "<A-1>", function()
	Snacks.terminal(nil, { env = { id = 1 }, win = { position = "bottom" } })
end, { desc = "Terminal" })

map({ "n", "v", "i", "t" }, "<A-2>", function()
	Snacks.terminal(nil, { env = { id = 2 }, win = { position = "bottom" } })
end, { desc = "Terminal" })

map({ "n", "v", "i", "t" }, "<A-3>", function()
	Snacks.terminal(nil, { env = { id = 3 }, win = { position = "bottom" } })
end, { desc = "Terminal" })

map({ "n", "v", "i", "t" }, "<A-4>", function()
	Snacks.terminal(nil, { env = { id = 4 }, win = { position = "bottom" } })
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
	},
}

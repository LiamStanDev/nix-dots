-- NOTE: If you encounter any terminal space key lagging, please
-- checkt `:verbose inoremap <space>`, `:verbose vnpremap <space>`
-- and `:verbose tnoremap <space>`.

local map = vim.keymap.set

local function show_term(id)
	Snacks.terminal(
		nil,
		{ env = { id = id }, win = { wo = { winbar = "Term: " .. id }, height = 0.3, position = "bottom" } }
	)
end

local modes = { "n", "v", "i", "t" }
local keys = { ["<A-`>"] = 0, ["<A-1>"] = 1, ["<A-2>"] = 2, ["<A-3>"] = 3, ["<A-4>"] = 4 }

for key, id in pairs(keys) do
	map(modes, key, function()
		show_term(id)
	end, { desc = "Terminal" })
end

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

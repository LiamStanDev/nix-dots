local opts = {
	animate = { enabled = false },
	bottom = {
		{
			ft = "noice",
			size = { height = 0.4 },
			filter = function(buf, win)
				return vim.api.nvim_win_get_config(win).relative == ""
			end,
		},
		"Trouble",
		{ ft = "qf", title = "QuickFix" },
		{
			ft = "help",
			size = { height = 20 },
			-- don't open help files in edgy that we're editing
			filter = function(buf)
				return vim.bo[buf].buftype == "help"
			end,
		},
	},
	left = {},
	right = {},
	keys = {
		-- increase width
		["<A-,>"] = function(win)
			win:resize("width", 2)
		end,
		-- decrease width
		["<A-.>"] = function(win)
			win:resize("width", -2)
		end,
		-- increase height
		["<A-+>"] = function(win)
			win:resize("height", 2)
		end,
		-- decrease height
		["<A-->"] = function(win)
			win:resize("height", -2)
		end,
	},
}

return function()
	for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
		opts[pos] = opts[pos] or {}
		table.insert(opts[pos], {
			ft = "trouble",
			filter = function(_buf, win)
				return vim.w[win].trouble
					and vim.w[win].trouble.position == pos
					and vim.w[win].trouble.type == "split"
					and vim.w[win].trouble.relative == "editor"
					and not vim.w[win].trouble_preview
			end,
		})
	end

	-- snacks terminal
	for _, pos in ipairs({ "top", "bottom", "left", "right" }) do
		opts[pos] = opts[pos] or {}
		table.insert(opts[pos], {
			ft = "snacks_terminal",
			size = { height = 0.4 },
			title = "%{b:snacks_terminal.id}: %{b:term_title}",
			filter = function(_buf, win)
				return vim.w[win].snacks_win
					and vim.w[win].snacks_win.position == pos
					and vim.w[win].snacks_win.relative == "editor"
					and not vim.w[win].trouble_preview
			end,
		})
	end

	-- copilot chat
	table.insert(opts.right, {
		ft = "copilot-chat",
		title = "Copilot Chat",
		size = { width = 60 },
	})
	return opts
end

-- split
local map_split = function(buf_id, lhs, direction)
	local rhs = function()
		-- Make new window and set it as target
		local cur_target = MiniFiles.get_explorer_state().target_window
		local new_target = vim.api.nvim_win_call(cur_target, function()
			vim.cmd(direction .. " split")
			return vim.api.nvim_get_current_win()
		end)

		MiniFiles.set_target_window(new_target)
		MiniFiles.go_in()
	end

	-- Adding `desc` will result into `show_help` entries
	local desc = "Split " .. direction
	vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = desc })
end

-- Yank in register full path of entry under cursor
local yank_path = function()
	local path = (MiniFiles.get_fs_entry() or {}).path
	if path == nil then
		return vim.notify("Cursor is not on valid entry")
	end
	vim.fn.setreg(vim.v.register, path)
end

local set_cwd = function()
	local path = (MiniFiles.get_fs_entry() or {}).path
	if path == nil then
		return vim.notify("Cursor is not on valid entry")
	end
	vim.fn.chdir(vim.fs.dirname(path))
end

return function()
	local minifiles = require("mini.files")
	minifiles.setup({
		mappings = {
			close = "q",
			go_in = "L",
			go_in_plus = "<CR>",
			go_out = "H",
			go_out_plus = "",
			mark_goto = "'",
			mark_set = "m",
			reset = "<BS>",
			reveal_cwd = "_",
			show_help = "g?",
			synchronize = "`",
			trim_left = "<",
			trim_right = ">",
		},
		windows = {
			preview = true,
			width_preview = 80,
		},
	})

	local map = vim.keymap.set
	map("n", "<leader>E", function()
		if minifiles.get_explorer_state() then
			minifiles.close()
		else
			minifiles.open()
		end
	end, { desc = "Explorer" })

	vim.api.nvim_create_autocmd("User", {
		pattern = "MiniFilesBufferCreate",
		callback = function(args)
			local buf_id = args.data.buf_id
			map_split(buf_id, "gs", "belowright horizontal")
			map_split(buf_id, "gv", "belowright vertical")
			vim.keymap.set("n", "gy", yank_path, { buffer = buf_id, desc = "Yank path" })
			vim.keymap.set("n", "_", set_cwd, { buffer = buf_id, desc = "Set cwd" })
		end,
	})
end

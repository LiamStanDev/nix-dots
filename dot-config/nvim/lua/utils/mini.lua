local M = {}

-- ref: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/util/mini.lua
--- Sets up custom behavior for the `mini.pairs` plugin.
-- This function modifies the behavior of the `mini.pairs.open` function to handle
-- specific cases such as markdown code blocks, skipping certain characters, and
-- unbalanced pairs based on the provided options.
-- @param opts A table of options to customize the behavior:
--   - `markdown` (boolean): Enable special handling for markdown code blocks.
--   - `skip_next` (string): A pattern to skip certain characters after the cursor.
--   - `skip_ts` (table): A list of Tree-sitter captures to skip.
--   - `skip_unbalanced` (boolean): Skip unbalanced pairs.
function M.pair(opts)
	local pairs = require("mini.pairs")
	pairs.setup(opts)
	local open = pairs.open
	pairs.open = function(pair, neigh_pattern)
		if vim.fn.getcmdline() ~= "" then
			return open(pair, neigh_pattern)
		end
		local o, c = pair:sub(1, 1), pair:sub(2, 2)
		local line = vim.api.nvim_get_current_line()
		local cursor = vim.api.nvim_win_get_cursor(0)
		local next = line:sub(cursor[2] + 1, cursor[2] + 1)
		local before = line:sub(1, cursor[2])
		if opts.markdown and o == "`" and vim.bo.filetype == "markdown" and before:match("^%s*``") then
			return "`\n```" .. vim.api.nvim_replace_termcodes("<up>", true, true, true)
		end
		return open(pair, neigh_pattern)
	end
end

return M

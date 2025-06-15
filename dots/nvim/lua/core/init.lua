local M = {}

function M.setup()
	require("core.options")
	require("core.keymaps")
	require("core.autocmds")
	require("plugins-setup")
end

return M

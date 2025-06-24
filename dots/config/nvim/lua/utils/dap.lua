local M = {}

--- Retrieves the system path separator.
-- @return A string representing the system path separator (e.g., "/" or "\\").
function M.get_sep()
	return package.config:sub(1, 1)
end

--- Gets the path to the Mason adapter binaries.
-- @return A string representing the path to the Mason adapter binaries.
function M.get_mason_adaptor_path()
	return vim.fn.stdpath("data") .. "/mason/bin/"
end

--- Prompts the user to input command-line arguments.
-- @return A table containing the parsed arguments as strings.
function M.read_args()
	local args_str = vim.fn.input("Arguments: ")
	if args_str == "" then
		return {}
	end
	return vim.split(args_str, " ", { trimempty = true })
end

--- Prompts the user to input the path to the target executable.
-- @return A string representing the path to the executable, or nil if no input is provided.
function M.read_target()
	local sep = package.config:sub(1, 1) -- System path separator
	local cwd = string.format("%s%s", vim.fn.getcwd(), sep)

	local path = vim.fn.input("Path to executable: ", cwd, "file")
	if path == "" then
		return nil
	end
	local dap = require("dap")
	return vim.fn.input("Path to executable: ", cwd, "file") or dap.ABORT
end

return M

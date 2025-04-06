local M = {}

-- 系統路徑分隔符
function M.get_sep()
	return package.config:sub(1, 1)
end

function M.get_mason_adaptor_path()
	return vim.fn.stdpath("data") .. "/mason/bin/"
end

-- 獲取命令行參數
function M.read_args()
	local args_str = vim.fn.input("Arguments: ")
	if args_str == "" then
		return {}
	end
	return vim.split(args_str, " ", { trimempty = true })
end

-- 讀取用戶手動輸入的目標
function M.read_target()
	local sep = package.config:sub(1, 1) -- 系統路徑分隔符
	local cwd = string.format("%s%s", vim.fn.getcwd(), sep)

	local path = vim.fn.input("Path to executable: ", cwd, "file")
	if path == "" then
		return nil
	end
	local dap = require("dap")
	return vim.fn.input("Path to executable: ", cwd, "file") or dap.ABORT
end

return M

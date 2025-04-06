local M = {}

function M.setup()
	local langs_path = vim.fn.stdpath("config") .. "/lua/config/dap/langs"
	local langs = vim.fn.glob(langs_path .. "/*.lua", false, true)

	local adaptors_path = vim.fn.stdpath("config") .. "/lua/config/dap/adaptors"
	local adaptors = vim.fn.glob(adaptors_path .. "/*.lua", false, true)

	for _, lang_file in ipairs(langs) do
		local lang_name = vim.fn.fnamemodify(lang_file, ":t:r")
		require("config.dap.langs." .. lang_name)
	end

	for _, adaptor_file in ipairs(adaptors) do
		local lang_name = vim.fn.fnamemodify(adaptor_file, ":t:r")
		require("config.dap.adaptors." .. lang_name)
	end
end

return M

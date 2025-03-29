local M = {}
M.make_unique_list = function(list)
	local temp_talbe = {}
	for i, value in ipairs(list) do
		temp_talbe[value] = i
	end
	local unique_list = {}
	for key, value in pairs(temp_talbe) do
		table.insert(unique_list, { key = key, index = value })
	end
	table.sort(unique_list, function(a, b)
		return a.index < b.index
	end)
	return unique_list
end

M.env_cleanup = function(venv)
	if string.find(venv, "/") then
		local final_venv = venv
		for w in venv:gmatch("([^/]+)") do
			final_venv = w
		end
		venv = final_venv
	end
	return venv
end

M.check_git_workspace = function()
	local filepath = vim.fn.expand("%:p:h")
	local gitdir = vim.fn.finddir(".git", filepath .. ";")
	return gitdir and #gitdir > 0 and #gitdir < #filepath
end

M.buffer_not_empty = function()
	return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
end

M.hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

return M

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

M.mason_updates = function()
	local registry = require("mason-registry")
	-- get a list of all installed package names
	local installed = registry.get_installed_package_names()
	local outdated_count = 0

	for _, name in ipairs(installed) do
		local pkg = registry.get_package(name)
		if pkg then
			-- synchronous call to get the latest available version
			local latest = pkg:get_latest_version()
			-- installed version is on pkg.version
			local current = pkg.version
			if current ~= latest then
				outdated_count = outdated_count + 1
			end
		end
	end

	-- return number of packages that can be upgraded (0 if none)
	return outdated_count
end

local copilot_status = function()
	local status_c, client = pcall(require, "copilot.client")
	local status_a, api = pcall(require, "copilot.api")
	if not status_c or not status_a then
		return "unknown"
	end

	if client.is_disabled() then
		return "disabled"
	end

	local is_buf_attached = client.buf_is_attached(vim.api.nvim_get_current_buf())
	if is_buf_attached then
		local status, data = pcall(api.status)
		if status and data.status == "warning" then
			return "warning"
		elseif status and data.status == "ok" then
			return "enabled"
		else
			return "sleep"
		end
	end

	return "unknown"
end
M.copilot_status_icon = function()
	local icons = {
		enabled = " ",
		sleep = " ",
		disabled = " ",
		warning = " ",
		unknown = " ",
	}

	return icons[copilot_status()] or icons.unknown
end

return M

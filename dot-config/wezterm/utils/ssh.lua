local wezterm = require("wezterm")

local M = {}

M.parse_ssh_config = function()
	local ssh_config_file
	if wezterm.target_triple:find("windows") then
		ssh_config_file = wezterm.home_dir .. "\\.ssh\\config"
	else
		ssh_config_file = wezterm.home_dir .. "/.ssh/config"
	end

	local hosts = {}
	local file = io.open(ssh_config_file, "r")
	if not file then
		return hosts
	end

	local current_host = nil
	for line in io.lines(ssh_config_file) do
		line = line:match("^%s*(.-)%s*$") -- Trim whitespace
		if line:match("^Host%s+") then
			current_host = line:match("^Host%s+(.*)")
		elseif current_host and line:match("^HostName%s+") then
			local hostname = line:match("^HostName%s+(.*)")
			table.insert(
				hosts,
				{ name = current_host, display_name = string.format("%s (%s)", current_host, hostname) }
			)
			current_host = nil
		end
	end

	return hosts
end

return M

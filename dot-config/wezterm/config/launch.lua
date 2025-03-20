local wezterm = require("wezterm")
local platform = require("utils.platform")()
local ssh_util = require("utils.ssh")
local catppuccin = require("colors.catppuccin")

local options = {
	default_prog = {},
	launch_menu = {},
}

-- label
local function create_label(text, color)
	return wezterm.format({
		{ Foreground = { Color = color } },
		{ Text = text },
	})
end

-- ssh
local ssh_hosts = ssh_util.parse_ssh_config()
if #ssh_hosts > 0 then
	table.insert(options.launch_menu, {
		label = create_label("=== SSH Hosts ===", catppuccin.mauve),
	})
	for _, host in ipairs(ssh_hosts) do
		table.insert(options.launch_menu, {
			label = create_label("SSH to " .. host.display_name, catppuccin.mauve),
			args = { "ssh", host.name },
		})
	end
end

-- platform specific
if platform.is_win then
	options.default_prog = { "wsl", "~" }
	table.insert(options.launch_menu, {
		label = create_label("=== Windows Terminals ===", catppuccin.yellow),
	})
	table.insert(options.launch_menu, {
		label = create_label("Ubuntu", catppuccin.yellow),
		args = { "wsl", "~" },
	})
	table.insert(options.launch_menu, {
		label = create_label("PowerShell Core", catppuccin.yellow),
		args = { "pwsh", "-NoLogo" },
	})
	table.insert(options.launch_menu, {
		label = create_label("Command Prompt", catppuccin.yellow),
		args = { "cmd" },
	})
	table.insert(options.launch_menu, {
		label = create_label("Git Bash", catppuccin.yellow),
		args = { "C:\\Program Files\\Git\\bin\\bash.exe" },
	})
elseif platform.is_mac then
	options.default_prog = { "/opt/homebrew/bin/fish", "-l" }
	table.insert(options.launch_menu, {
		label = create_label("=== macOS Terminals ===", catppuccin.yellow),
	})
	table.insert(options.launch_menu, {
		label = create_label("Bash", catppuccin.yellow),
		args = { "bash", "-l" },
	})
	table.insert(options.launch_menu, {
		label = create_label("Fish", catppuccin.yellow),
		args = { "/opt/homebrew/bin/fish", "-l" },
	})
	table.insert(options.launch_menu, {
		label = create_label("Zsh", catppuccin.yellow),
		args = { "zsh", "-l" },
	})
elseif platform.is_linux then
	options.default_prog = { "zsh" }
	table.insert(options.launch_menu, {
		label = create_label("=== Linux Terminals ===", catppuccin.yellow),
	})
	table.insert(options.launch_menu, {
		label = create_label("Bash", catppuccin.yellow),
		args = { "bash" },
	})
	table.insert(options.launch_menu, {
		label = create_label("Zsh", catppuccin.yellow),
		args = { "zsh" },
	})
	table.insert(options.launch_menu, {
		label = create_label("Fish", catppuccin.yellow),
		args = { "fish", "-l" },
	})
end

return options

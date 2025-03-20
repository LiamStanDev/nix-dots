local use_pokemon = vim.fn.executable("pokemon-colorscripts") == 1

local sections = {}

if use_pokemon then
	table.insert(sections, {
		pane = 1,
		section = "terminal",
		-- cmd = "pokemon-colorscripts -n zacian --no-title; sleep .1",
		cmd = "pokemon-colorscripts -n quagsire --no-title; sleep .1",
		indent = 15,
		height = 20,
	})
else
	table.insert(sections, {
		pane = 1,
		section = "header",
		indent = 15,
		height = 20,
	})
end

table.insert(sections, { section = "startup", padding = 1 })
table.insert(sections, { pane = 2, section = "keys", gap = 1, padding = 1 })
table.insert(sections, {
	pane = 2,
	icon = " ",
	desc = "Browse Repo",
	padding = 1,
	key = "b",
	action = function()
		Snacks.gitbrowse()
	end,
})
table.insert(sections, {
	pane = 2,
	icon = " ",
	title = "Recent Files",
	section = "recent_files",
	indent = 2,
	padding = 1,
})
table.insert(sections, {
	pane = 2,
	icon = " ",
	title = "Projects",
	section = "projects",
	indent = 2,
	padding = 1,
})

return {
	enabled = true,
	preset = {
		keys = {
			{ icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
			{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
			{ icon = " ", key = "g", desc = "Grep", action = ":lua Snacks.dashboard.pick('live_grep')" },
			{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
			{
				icon = " ",
				key = "c",
				desc = "Config",
				action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
			},
			{ icon = " ", key = "s", desc = "Restore Session", section = "session" },
			{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
			{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
		},
		header = [[
⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⣠⡴⣟⣳⣶⣖⣤⢌⡙⠲⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⣴⣽⠟⢛⣭⣿⣿⣿⣿⣮⣢⢼⡷⢄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⢰⣿⠁⣴⣿⣿⣿⣿⣿⣀⣸⣿⢸⠀⡨⡇⠀⠀⢀⣀⠠⣀⠀
⠀⢸⣿⢸⣿⠿⠿⠛⠿⢿⣿⣷⣿⡮⣳⡤⣃⠴⡊⠁⠀⠀⠀⡇
⠀⣨⢻⠁⠀⠀⠀⠀⠀⣠⣿⣿⣿⣷⣱⠋⠀⠀⠳⡀⠀⣠⠞⠀
⢠⠃⠘⢄⣀⢤⣐⣦⣵⣿⣿⣿⣿⣿⠃⣀⠀⣀⢠⡽⠚⠁⠀⠀
⠘⣆⡀⠀⠙⠻⢻⠿⠿⠯⢗⡻⠕⠁⠠⢔⢲⢎⠁⢳⡀⠀⠀⠀
⠀⠈⠙⠲⠦⠬⢆⠔⠗⠒⠒⠒⡖⣆⣀⠼⠾⠪⣦⠔⢣⠀⠀⠀
⠀⠀⠀⠀⠀⠀⣿⡄⠠⡄⣯⡿⡟⢦⠶⠶⠼⠛⡵⣦⣸⠀⠀⠀
⠀⠀⠀⠀⢀⡴⠚⠯⡭⢥⡭⠴⠓⠺⠀⠀⠀⠀⠹⡤⠊⠀⠀⠀
⠀⠀⠀⢠⠛⠠⠤⣀⠒⢘⣱⠤⢤⣒⡡⠤⠄⠀⠀⢱⠀⠀⠀⠀
⠀⠀⠀⢸⠀⠀⠀⠀⢹⠃⠀⠀⠀⠀⠙⢦⡤⠔⠒⠁⢇⠀⠀⠀
⠀⠀⡤⠚⠒⠒⠀⢀⣸⠀⠀⠀⠀⠀⠀⠈⣶⡀⠐⠊⠉⠓⢦⠀
⠀⠀⠫⢖⣂⣀⡰⠮⠃⠀⠀⠀⠀⠀⠀⠀⠘⠮⠶⠄⠠⠤⠞⠀
        ]],
	},
	sections = sections,
}

local function get_plugins_num()
	return #require("lazy").plugins()
end

return function()
	local alpha_status, alpha = pcall(require, "alpha")
	if not alpha_status then
		print("alpha not found")
		return
	end
	local logo_name = require("core.globals").dashboard_logo
	local logos = require("settings.style.header")
	if logos[logo_name] == nil then
		logo_name = "LiamVimVer3"
	end
	local dashboard = require("alpha.themes.dashboard")
	dashboard.section.header.val = logos[logo_name]

	dashboard.section.buttons.val = {
		dashboard.button("f", "  Find File", "<CMD>Telescope find_files<CR>"),
		dashboard.button("e", "󰙅  Explorer", "<CMD>lua MiniFiles.open()<CR>"),
		dashboard.button("r", "  Recent files", ":Telescope oldfiles<CR>"),
		dashboard.button("t", "󰇉  Find Text", "<CMD>Telescope live_grep<CR>"),
		dashboard.button("c", "  Configuration", ":e $MYVIMRC<CR>"),
		dashboard.button("q", "󱎘  Quit", "<CMD>quit<CR>"),
	}
	local function footer()
		-- Number of plugins
		local total_plugins = get_plugins_num()
		local datetime = os.date("%d-%m-%Y %H:%M:%S")
		local plugins_text = "\n\n"
			.. "⚡"
			.. "   "
			.. total_plugins
			.. " plugins"
			.. "  󰁪 "
			.. vim.version().major
			.. "."
			.. vim.version().minor
			.. "."
			.. vim.version().patch
			.. "  󱛡 "
			.. datetime

		-- Quote
		local fortune = require("alpha.fortune")
		local quote = table.concat(fortune(), "\n")

		return plugins_text .. "\n" .. quote
	end

	dashboard.section.footer.val = footer()

	dashboard.section.footer.opts.hl = "Type"
	dashboard.section.header.opts.hl = "Include"
	dashboard.section.buttons.opts.hl = "Keyword"

	dashboard.opts.opts.noautocmd = true

	alpha.setup(dashboard.opts)
end

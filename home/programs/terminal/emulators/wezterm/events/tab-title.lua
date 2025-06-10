local wezterm = require("wezterm")

local M = {}

local function tab_title(tab_info)
	local title = tab_info.tab_title

	if title and #title > 0 then
		return title
	end
	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

M.setup = function()
	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local title = tab_title(tab)
		if tab.is_active then
			return {
				{ Text = " " .. title .. " " },
			}
		end

		return {
			{ Text = " " .. title .. " " },
		}
	end)
end

return M

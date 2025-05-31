local wezterm = require("wezterm")
local act = wezterm.action
local leader = { key = "Space", mods = "CTRL", timeout_milliseconds = 1000 }

-- stylua: ignore
local keys = {
   -- useful fn
   { key = 'F2',    mode = 'NONE',        action = act.ActivateCopyMode },
   { key = 'F3',    mode = 'NONE',        action = act.ShowLauncherArgs{flags = "LAUNCH_MENU_ITEMS|FUZZY"} },
   { key = 'F11',   mods = 'NONE',        action = act.ToggleFullScreen },
   { key = 'F12',   mods = 'NONE',        action = act.ShowDebugOverlay },

   -- copy/paste
   { key = 'c',     mods = 'CTRL|SHIFT',  action = act.CopyTo('Clipboard') },
   { key = 'v',     mods = 'CTRL|SHIFT',  action = act.PasteFrom('Clipboard') },

   -- panes
   -- { key = 'k',     mods = 'CTRL|ALT',    action = act.ActivatePaneDirection('Up') },
   -- { key = 'j',     mods = 'CTRL|ALT',    action = act.ActivatePaneDirection('Down') },
   -- { key = 'h',     mods = 'CTRL|ALT',    action = act.ActivatePaneDirection('Left') },
   -- { key = 'l',     mods = 'CTRL|ALT',    action = act.ActivatePaneDirection('Right') },

   -- { key = [[\]],   mods = 'CTRL|ALT',      action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
   -- { key = [[-]],   mods = 'CTRL|ALT',      action = act.SplitVertical { domain = 'CurrentPaneDomain' } },

   -- { key = 'k',     mods = 'LEADER',      action = act.AdjustPaneSize({ "Up", 5 }) },
   -- { key = 'j',     mods = 'LEADER',      action = act.AdjustPaneSize({ "Down", 5 }) },
   -- { key = 'h',     mods = 'LEADER',      action = act.AdjustPaneSize({ "Left", 15 }) },
   -- { key = 'l',     mods = 'LEADER',      action = act.AdjustPaneSize({ "Right", 15 }) },

   -- { key = 's',     mods = 'CTRL|ALT',      action = act.PaneSelect({ alphabet = "1234567890", mode = "SwapWithActiveKeepFocus" }) },
   -- { key = 'f',     mods = 'CTRL|ALT',      action = act.TogglePaneZoomState },
   -- { key = 'x',     mods = 'CTRL|ALT',      action = act.CloseCurrentPane({ confirm = false }) },

   -- tab
   -- { key = 't',     mods = 'CTRL|ALT',      action = act.SpawnTab('CurrentPaneDomain') },
   -- { key = 'x',     mods = 'CTRL|ALT',      action = act.CloseCurrentTab({ confirm = false }) },

   -- { key = '[',     mods = 'CTRL|ALT',      action = act.ActivateTabRelative(-1) },
   -- { key = ']',     mods = 'CTRL|ALT',      action = act.ActivateTabRelative(1) },
   -- { key = '{',     mods = 'CTRL|ALT|SHIFT',      action = act.MoveTabRelative(-1) },
   -- { key = '}',     mods = 'CTRL|ALT|SHIFT',      action = act.MoveTabRelative(1) },


   { key = 't',     mods = 'LEADER',      action = act.SpawnTab('CurrentPaneDomain') },
   { key = 'x',     mods = 'LEADER',      action = act.CloseCurrentTab({ confirm = false }) },

   { key = '[',     mods = 'LEADER',      action = act.ActivateTabRelative(-1) },
   { key = ']',     mods = 'LEADER',      action = act.ActivateTabRelative(1) },
   { key = '{',     mods = 'LEADER|SHIFT',      action = act.MoveTabRelative(-1) },
   { key = '}',     mods = 'LEADER|SHIFT',      action = act.MoveTabRelative(1) },


   -- resizes fonts
   {
      key = 'f',
      mods = 'LEADER',
      action = act.ActivateKeyTable({
         name = 'resize_font',
         one_shot = false,
         timemout_miliseconds = 1000,
      }),
   },
   -- resize panes
   -- {
   --    key = 'p',
   --    mods = 'LEADER',
   --    action = act.ActivateKeyTable({
   --       name = 'resize_pane',
   --       one_shot = false,
   --       timemout_miliseconds = 1000,
   --    }),
   -- },

}

-- stylua: ignore
local key_tables = {
   resize_font = {
      { key = 'k',      action = act.IncreaseFontSize },
      { key = 'j',      action = act.DecreaseFontSize },
      { key = 'r',      action = act.ResetFontSize },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q',      action = 'PopKeyTable' },
   },
   resize_pane = {
      { key = 'k',      action = act.AdjustPaneSize({ 'Up', 5 }) },
      { key = 'j',      action = act.AdjustPaneSize({ 'Down', 5 }) },
      { key = 'h',      action = act.AdjustPaneSize({ 'Left', 5 }) },
      { key = 'l',      action = act.AdjustPaneSize({ 'Right', 5 }) },
      { key = 'Escape', action = 'PopKeyTable' },
      { key = 'q',      action = 'PopKeyTable' },
   },
}

local mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "CTRL",
		action = act.OpenLinkAtMouseCursor,
	},
}

return {
	disable_default_key_bindings = true,
	leader = leader,
	keys = keys,
	key_tables = key_tables,
	mouse_bindings = mouse_bindings,
}

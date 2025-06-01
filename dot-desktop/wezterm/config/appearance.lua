local colors = require("colors.colorscheme")

return {
	term = "xterm-256color",
	enable_wayland = true,

	-- gpu (vm can't use webgpu)
	front_end = "OpenGL", -- WebGpu, OpenGL (Support transparent background in windows), Software
	-- prefer_egl = true,
	webgpu_preferred_adapter = require("utils.gpu").pick_gpu(),
	webgpu_power_preference = "HighPerformance",
	-- window_decorations = "TITLE | RESIZE",
	-- window_decorations = "RESIZE",
	window_decorations = "NONE",

	-- background
	text_background_opacity = 1,
	window_background_opacity = 0.95,
	-- background = {
	-- 	{
	-- 		source = {
	-- 			File = "C:\\Users\\liam\\Pictures\\Wallpapers\\wallhaven-6dvj7w2.png",
	-- 		},
	-- 		hsb = { brightness = 0.2, hue = 1, saturation = 1 },
	-- 		vertical_align = "Middle",
	-- 		horizontal_align = "Center",
	-- 		opacity = 0.1,
	-- 		-- height = "Contain",
	-- 		-- width = "Contain",
	-- 		repeat_x = "NoRepeat",
	-- 		repeat_y = "NoRepeat",
	-- 	},
	-- },

	-- fps
	animation_fps = 60,
	max_fps = 144,

	-- colorscheme
	color_scheme = "Catppuccin Frappe",

	-- tab bar
	enable_tab_bar = true,
	hide_tab_bar_if_only_one_tab = false,
	use_fancy_tab_bar = false,
	tab_max_width = 25,
	-- show_tab_index_in_tab_bar = true, -- override by events
	switch_to_last_active_tab_when_closing_tab = true,
	tab_bar_at_bottom = true,
	show_new_tab_button_in_tab_bar = false,

	-- window
	window_padding = {
		left = 15,
		right = 10,
		top = 12,
		bottom = 7,
	},
	window_close_confirmation = "NeverPrompt",
	-- window_frame = {
	-- 	active_titlebar_bg = "#090909",
	-- },

	-- pane
	inactive_pane_hsb = {
		saturation = 1.0,
		brightness = 0.8,
	},
}

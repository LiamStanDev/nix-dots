return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = true,
			no_italic = true,

			custom_highlights = {
				-- trouble
				TroubleIconDirectory = { fg = "#8caaee" },
				TroubleIconFile = { fg = "#6DC85E" },

				-- ref: https://www.reddit.com/r/neovim/comments/11l5p32/how_can_i_change_the_color_of_the_column_that/
				LineNr = { fg = "#9399b2", bg = "NONE", bold = false },
				CursorLineNr = { fg = "#f0f6fc", bg = "NONE", bold = true },
			},
		},
	},
}

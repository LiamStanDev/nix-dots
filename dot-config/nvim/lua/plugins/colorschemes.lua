return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			transparent_background = true,
			no_italic = true,

			custom_highlights = {
				NeoTreeFileIcon = { fg = "#6DC85E" },
				NeoTreeDirectoryName = { fg = "#A3AAB7" },
				-- NeoTreeDirectoryIcon = { fg = "#89B4FA" },
				NeoTreeDirectoryIcon = { fg = "#868687" },
				NeoTreeExpander = { fg = "#7D8590" },
				NeoTreeIndentMarker = { fg = "#7D8590" },
				-- indent scope
				MiniIndentscopeSymbol = { fg = "#BA7ACE" },
				-- trouble
				TroubleIconDirectory = { fg = "#868687" },
				TroubleIconFile = { fg = "#6DC85E" },

				-- ref: https://www.reddit.com/r/neovim/comments/11l5p32/how_can_i_change_the_color_of_the_column_that/
				LineNr = { fg = "#9399b2", bg = "NONE", bold = false },
				CursorLineNr = { fg = "#f0f6fc", bg = "NONE", bold = true },

				-- CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", strikethrough = true },
				-- CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", bold = true },
				-- CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", bold = true },
				-- CmpItemMenu = { fg = "#C792EA", bg = "NONE", italic = false },
				-- CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
				-- CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
				-- CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },
				-- CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
				-- CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
				-- CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },
				-- CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
				-- CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
				-- CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },
				-- CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
				-- CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
				-- CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
				-- CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
				-- CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },
				-- CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
				-- CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },
				-- CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
				-- CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
				-- CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },
				-- CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
				-- CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
				-- CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },
				-- CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
				-- CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
				-- CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },
			},
		},
	},
}

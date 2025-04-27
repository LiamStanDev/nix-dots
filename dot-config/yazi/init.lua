require("full-border"):setup()
-- require("no-status"):setup()
-- require("git"):setup()
require("yaziline"):setup({
	separator_style = "curvy",
	select_symbol = "",
	yank_symbol = "󰆐",
	filename_max_length = 24, -- trim when filename > 24
	filename_trim_length = 6, -- trim 6 chars from both ends
})

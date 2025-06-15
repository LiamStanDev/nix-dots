local Config = require("config")

-- require("events.full-screen").setup()
require("events.tab-title").setup()
-- require("events.tab-button").setup()

return Config:init()
	:append(require("config.appearance"))
	:append(require("config.keymaps"))
	:append(require("config.domains"))
	:append(require("config.general"))
	:append(require("config.fonts"))
	:append(require("config.launch")).options

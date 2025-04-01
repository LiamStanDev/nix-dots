-- the core plugins
require("core")
local config = require("core.globals")

-- -----------------------------------------------------
-- Register server
-- -----------------------------------------------------
-- tree-sitter code highlight
config.code_hight_servers = {
	"regex",
	"json",
	"javascript",
	"tsx",
	"html",
	"css",
	"markdown",
	"markdown_inline",
	"bash",
	"lua",
	"vim",
	"dockerfile",
	"gitignore",
	"cpp",
	"make",
	"cmake",
	"rust",
	"sql",
	"just",
	"asm",
}

-- lsp server for auto completion
-- see https://github.com/williamboman/mason-lspconfig.nvim
config.lsp_servers = {
	-- "html",
	-- "jsonls",
	"lua_ls",
	-- "cssls",
	"pyright",
	"bashls",
	-- "dockerls",
	"ts_ls",
	-- "tailwindcss",
	"taplo", -- toml lsp
	"rust_analyzer",
	-- "gopls",
	"cmake",
	"clangd",
	"nil_ls", -- nix
}

-- formatters
-- see: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
config.formatter_services = {
	lua = { "stylua" },
	python = { "ruff_format" },
	-- python = { "ruff_format", "ruff_fix" }, -- ruff_fix will auto fix lint
	javascript = { "prettierd", "prettier", stop_after_first = true },
	typescript = { "prettierd", "prettier", stop_after_first = true },
	typescriptreact = { "prettierd", "prettier", stop_after_first = true },
	html = { "prettierd", "prettier", stop_after_first = true },
	toml = { "prettierd", "prettier", stop_after_first = true },
	json = { "prettierd", "prettier", stop_after_first = true },
	bash = { "shfmt" },
	zsh = { "shfmt" },
	sh = { "shfmt" },
	c = { "clang_format" },
	cpp = { "clang_format" },
	cmake = { "gersemi" },
	-- rust = { "rustfmt" },
	-- cs = { "csharpier" },
	sql = { "sqlfmt" },
	nix = { "nixpkgs_fmt" },
}

-- linter
-- see: https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
config.linting_services = {
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	python = { "ruff" },
}

-- debuger server
-- see: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
config.dap_servers = {
	"python",
	"cppdbg",
	"codelldb",
	-- "delve", -- go
}

-- -----------------------------------------------------
-- Others
-- -----------------------------------------------------
-- set color theme here
config.colorscheme = "catppuccin"

-- border style
config.cmp_window_border = "single" -- none, single, rounded
config.lspsaga_window_border = "single" -- none, single, rounded
config.which_key_window_border = "single" -- none, single, double, shadow

-- show inline hint
config.open_type_hint = true -- for variable
config.open_parameter_hint = true

-- setup all plugin
require("plugins-setup")

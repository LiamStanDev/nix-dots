-- the core plugins
local G = require("core")

-- -----------------------------------------------------
-- Register server
-- -----------------------------------------------------
-- tree-sitter code highlight
G.code_hl_servers = {
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
G.lsp_servers = {
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
G.formatters = {
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
	sql = { "sqlfmt" },
	nix = { "nixpkgs_fmt" },
}

-- linter
-- see: https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
G.linters = {
	javascript = { "eslint_d" },
	javascriptreact = { "eslint_d" },
	typescript = { "eslint_d" },
	typescriptreact = { "eslint_d" },
	python = { "ruff" },
}

-- debuger server
-- see: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
G.dap_servers = {
	"python",
	"cppdbg",
	"codelldb",
	-- "delve", -- go
}

-- -----------------------------------------------------
-- Others
-- -----------------------------------------------------
-- set color theme here
G.colorscheme = "catppuccin"
G.quit_bad_habit = true

-- border style
G.cmp_window_border = "single" -- none, single, rounded
G.which_key_window_border = "single" -- none, single, double, shadow

-- setup all plugin
G.setup()

-- Core plugins and configuration setup.
local G = require("core")

-- -----------------------------------------------------
-- Register server configurations
-- -----------------------------------------------------

-- Tree-sitter code highlight servers.
-- These servers are used for syntax highlighting and parsing.
-- stylua: ignore
G.code_hl_servers = {
	"regex", "json5", "javascript", "tsx", "html", "css", "markdown", "markdown_inline",
	"bash", "lua", "vim", "dockerfile", "gitignore", "cpp", "make", "cmake", "rust",
	"sql", "just", "asm", "nix"
}

-- LSP servers for auto-completion.
-- These servers provide language-specific features like code completion, linting, and more.
-- See https://github.com/williamboman/mason-lspconfig.nvim for details.
-- stylua: ignore
G.lsp_servers = {
	"lua_ls", "pyright", "bashls", "ts_ls", "taplo", "rust_analyzer", "cmake",
	"clangd", "nil_ls", "dockerls", "docker_compose_language_service"
}

-- Formatters for code formatting.
-- See: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
-- stylua: ignore
G.formatters = {
	lua = { "stylua" }, -- Lua formatter
	python = { "ruff_format" }, -- Python formatter
	javascript = { "prettierd", "prettier", stop_after_first = true }, -- JavaScript
	typescript = { "prettierd", "prettier", stop_after_first = true }, -- TypeScript
	typescriptreact = { "prettierd", "prettier", stop_after_first = true }, -- React
	html = { "prettierd", "prettier", stop_after_first = true }, -- HTML
	toml = { "prettierd", "prettier", stop_after_first = true }, -- TOML
	json = { "prettierd", "prettier", stop_after_first = true }, -- JSON
	bash = { "shfmt" }, -- Bash
	zsh = { "shfmt" }, -- Zsh
	sh = { "shfmt" }, -- Shell
	c = { "clang_format" }, -- C
	cpp = { "clang_format" }, -- C++
	cmake = { "gersemi" }, -- CMake
	sql = { "sqlfmt" }, -- SQL
	nix = { "nixpkgs_fmt" }, -- Nix
}

-- Linters for code linting.
-- See: https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
-- stylua: ignore
G.linters = {
	javascript = { "eslint_d" }, -- JavaScript linter
	javascriptreact = { "eslint_d" }, -- React linter
	typescript = { "eslint_d" }, -- TypeScript linter
	typescriptreact = { "eslint_d" }, -- React TypeScript linter
	python = { "ruff" }, -- Python linter
}

-- Debugger servers for debugging support.
-- See: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
-- stylua: ignore
G.dap_servers = {
	"python", "cppdbg", "codelldb",
}

-- -----------------------------------------------------
-- Other configurations
-- -----------------------------------------------------

-- Set the color theme.
G.colorscheme = "catppuccin" -- gruvbox

-- Disable the quit confirmation dialog.
G.quit_bad_habit = false

-- Set border styles for UI components.
G.cmp_window_border = "single" -- Options: none, single, rounded
G.which_key_window_border = "single" -- Options: none, single, double, shadow
G.terminal_border = "single" -- Options: rounded, single, double, solid, shadow
G.picker_border = "single" -- Options: rounded, single, double, solid, shadow

-- Exclude patterns for search.
-- These patterns define files and directories to ignore during search operations.
-- stylua: ignore
G.exclude_pattern = {
	-- General
	".git", ".DS_Store", ".idea", ".vscode", ".history", ".github", "dist", "build", "out", "*.swp", "*.log", ".cache", "tmp", "*.bckp",
	-- Node/JS
	"node_modules", "package-lock.json", "yarn.lock", ".npm",
	-- Python
	"__pycache__", ".venv", "venv", "env", "*.pyc", "*.pyo", "*.pyd", ".pytest_cache", ".coverage",
	-- Rust
	"Cargo.lock", "target", "*.rs.bk", ".cargo",
	-- C/C++
	"*.o", "*.a", "*.so", "*.dll", "*.exe", "*.obj", "CMakeFiles", "CMakeCache.txt", "compile_commands.json",
	-- Go
	"vendor", "go.sum", "*.test",
}

-- Initialize and set up all plugins.
G.setup()

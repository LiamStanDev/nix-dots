-- Core plugins and configuration setup.
local G = require("core")

-- -----------------------------------------------------
-- Register server configurations
-- -----------------------------------------------------

-- Tree-sitter code highlight servers.
-- These servers are used for syntax highlighting and parsing.
G.code_hl_servers = {
	"regex", -- Regular expressions
	"json5", -- JSON
	"javascript", -- JavaScript
	"tsx", -- TypeScript JSX
	"html", -- HTML
	"css", -- CSS
	"markdown", -- Markdown
	"markdown_inline", -- Inline Markdown
	"bash", -- Bash scripts
	"lua", -- Lua
	"vim", -- Vimscript
	"dockerfile", -- Dockerfile
	"gitignore", -- Gitignore files
	"cpp", -- C++
	"make", -- Makefiles
	"cmake", -- CMake
	"rust", -- Rust
	"sql", -- SQL
	"just", -- Justfiles
	"asm", -- Assembly
	"nix", -- Nix
}

-- LSP servers for auto-completion.
-- These servers provide language-specific features like code completion, linting, and more.
-- See https://github.com/williamboman/mason-lspconfig.nvim for details.
G.lsp_servers = {
	"lua_ls", -- Lua
	"pyright", -- Python
	"bashls", -- Bash
	"ts_ls", -- TypeScript
	"taplo", -- TOML
	"rust_analyzer", -- Rust
	"cmake", -- CMake
	"clangd", -- C/C++
	"nil_ls", -- Nix
	"dockerls", -- Dockerfile
	"docker_compose_language_service", -- Docker Compose
}

-- Formatters for code formatting.
-- See: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
-- stylua: ignore start
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
-- stylua: ignore end

-- Linters for code linting.
-- See: https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
G.linters = {
	javascript = { "eslint_d" }, -- JavaScript linter
	javascriptreact = { "eslint_d" }, -- React linter
	typescript = { "eslint_d" }, -- TypeScript linter
	typescriptreact = { "eslint_d" }, -- React TypeScript linter
	python = { "ruff" }, -- Python linter
}

-- Debugger servers for debugging support.
-- See: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
G.dap_servers = {
	"python", -- Python debugger
	"cppdbg", -- C++ debugger
	"codelldb", -- Rust debugger
}

-- -----------------------------------------------------
-- Other configurations
-- -----------------------------------------------------

-- Set the color theme.
G.colorscheme = "catppuccin"

-- Disable the quit confirmation dialog.
G.quit_bad_habit = false

-- Set border styles for UI components.
G.cmp_window_border = "single" -- Options: none, single, rounded
G.which_key_window_border = "single" -- Options: none, single, double, shadow

-- Exclude patterns for search.
-- These patterns define files and directories to ignore during search operations.
-- stylua: ignore start
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
-- stylua: ignore end

-- Initialize and set up all plugins.
G.setup()

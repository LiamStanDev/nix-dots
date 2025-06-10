--[[
  init.lua
  Neovim main configuration entry point.

  - Maintains core plugin and server settings.
  - Frequently changed tables (servers, formatters, linters) are kept here for convenience.
  - All options are documented for clarity and maintainability.
  - See each section for links to upstream documentation.
]]

-- Load core configuration module (lua/core/init.lua must exist).
local G = require("core")

-- =====================================================
-- Server and Tool Registrations
-- =====================================================

--[[ Tree-sitter code highlight servers
  Used for syntax highlighting and parsing.
  Add or remove languages as needed.
  See: https://github.com/nvim-treesitter/nvim-treesitter
]]
-- stylua: ignore
G.code_hl_servers = {
  "regex", "json5", "javascript", "tsx", "html", "css", "markdown", "markdown_inline",
  "bash", "lua", "vim", "dockerfile", "gitignore", "cpp", "make", "cmake", "rust",
  "sql", "just", "asm", "nix"
}

--[[ LSP servers for auto-completion and language features
  Provides code completion, linting, etc.
  See: https://github.com/williamboman/mason-lspconfig.nvim
]]
-- stylua: ignore
G.lsp_servers = {
  "lua_ls", "pyright", "bashls", "ts_ls", "taplo", "rust_analyzer", "cmake",
  "clangd", "nil_ls", "dockerls", "docker_compose_language_service", "jsonls",
  "html", "postgres_lsp"
}

--[[ Formatters for code formatting
  Each language can have multiple formatters.
  stop_after_first = true: stops after first successful formatter.
  See: https://github.com/stevearc/conform.nvim?tab=readme-ov-file#formatters
]]
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
  nix = { "alejandra" }, -- Nix other options: nixpkg_fmt
}

--[[ Linters for code linting
  Uncomment JavaScript/TypeScript linters if needed.
  See: https://github.com/mfussenegger/nvim-lint?tab=readme-ov-file#available-linters
]]
-- stylua: ignore
G.linters = {
  -- javascript = { "eslint_d" }, -- JavaScript linter
  -- javascriptreact = { "eslint_d" }, -- React linter
  -- typescript = { "eslint_d" }, -- TypeScript linter
  -- typescriptreact = { "eslint_d" }, -- React TypeScript linter
  python = { "ruff" }, -- Python linter
}

--[[ Debugger servers for debugging support
  See: https://github.com/jay-babu/mason-nvim-dap.nvim/blob/main/lua/mason-nvim-dap/mappings/source.lua
]]
-- stylua: ignore
G.dap_servers = {
  "python", "cppdbg", "codelldb",
}

-- =====================================================
-- UI and Miscellaneous Options
-- =====================================================

--[[ Set the color theme
  Change to your preferred theme (e.g., "gruvbox", "catppuccin").
]]
G.colorscheme = "catppuccin"

--[[ Disable the quit confirmation dialog
  Set to true to disable confirmation when quitting.
]]
G.quit_bad_habit = false

--[[ Set border styles for UI components
  Options: "none", "single", "rounded", "double", "solid", "shadow"
]]
G.cmp_window_border = "single"
G.which_key_window_border = "single"
G.terminal_border = "single"
G.picker_border = "single"

--[[ Exclude patterns for search
  Files or directories to ignore during search operations.
]]
-- stylua: ignore
G.exclude_pattern = {
  ".git", "node_modules"
}

-- =====================================================
-- Plugin Initialization
-- =====================================================

--[[ Initialize and set up all plugins
  This should be called after all configuration above.
]]
G.setup()

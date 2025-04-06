local function build_capabilities()
	-- Initialize LSP client capabilities.
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	-- Extend capabilities with additional LSP features from the `blink.cmp` plugin.
	capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

	-- Enable experimental features for the Rust Analyzer.
	capabilities.experimental = {
		hoverActions = true, -- Enable hover actions for better code insights.
		colorDiagnosticOutput = true, -- Enable colorized diagnostic output.
		hoverRange = true, -- Enable hover range support.
		serverStatusNotification = true, -- Enable server status notifications.
		snippetTextEdit = true, -- Enable snippet text edits.
		codeActionGroup = true, -- Enable grouped code actions.
		ssr = true, -- Enable structural search and replace.
	}

	-- enable auto-import
	capabilities.textDocument.completion.completionItem.resolveSupport = {
		properties = { "documentation", "detail", "additionalTextEdits" },
	}

	capabilities.experimental.commands = {
		commands = {
			"rust-analyzer.runSingle", -- Run a single test or binary.
			"rust-analyzer.showReferences", -- Show references for a symbol.
			"rust-analyzer.gotoLocation", -- Go to a specific location.
			"editor.action.triggerParameterHints", -- Trigger parameter hints.
			"rust-analyzer.debugSingle",
		},
	}

	return capabilities
end

return {
	cmd = { "rust-analyzer" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
	},
	capabilities = build_capabilities(),
	filetypes = { "rust" },
	settings = {
		-- ref: https://raw.githubusercontent.com/rust-analyzer/rust-analyzer/master/editors/code/package.json
		["rust-analyzer"] = {
			check = {
				enabled = true,
				command = "clippy", -- Use Clippy for linting.
				features = "all",
				-- extraArgs = { "--no-deps" }, -- Only check/analyze your project's own code
			},
			checkOnSave = true,
			diagnostics = {
				experimental = {
					enable = true, -- Enable experimental diagnostics.
				},
			},
			cargo = {
				allTargets = false, -- Do not check all targets by default.
				features = "all", -- Enable all features.
				buildScripts = {
					enable = true, -- Enable build script support.
				},
			},
			procMacro = {
				enable = true, -- Enable procedural macros.
			},
			imports = {
				granularity = {
					group = "module", -- Group imports by module.
				},
				prefix = "self", -- Use `self` as the import prefix.
			},
		},
	},
}

local ra = require("utils.rust_analyzer")

return {
	cmd = { "rust-analyzer" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
	},
	capabilities = {
		experimental = {
			-- hoverActions = true, -- Enable hover actions for better code insights.
			colorDiagnosticOutput = true, -- Enable colorized diagnostic output.
			hoverRange = true, -- Enable hover range support.
			serverStatusNotification = true, -- Enable server status notifications.
			-- snippetTextEdit = true, -- Enable snippet text edits.
			-- codeActionGroup = true, -- Enable grouped code actions.
			ssr = true, -- Enable structural search and replace.
		},
		textDocument = {
			completion = {
				completionItem = {
					resolveSupport = {
						properties = { "documentation", "detail", "additionalTextEdits" },
					},
				},
			},
		},
	},
	filetypes = { "rust" },
	settings = {
		-- ref: https://rust-analyzer.github.io/book/configuration.html
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
				ignored = {
					["async-trait"] = { "async_trait" },
					["napi-derive"] = { "napi" },
					["async-recursion"] = { "async_recursion" },
				},
			},
			imports = {
				granularity = {
					group = "module", -- Group imports by module.
				},
				prefix = "self", -- Use `self` as the import prefix.
			},
			files = {
				excludeDirs = {
					".direnv",
					".git",
					".github",
					".gitlab",
					"bin",
					"node_modules",
					"target",
					"venv",
					".venv",
				},
			},
		},
	},
}

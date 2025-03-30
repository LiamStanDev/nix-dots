return {
	cmd = { "rust-analyzer" },
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
	},
	filetypes = { "rust" },
	capabilities = {
		experimental = {
			serverStatusNotification = true,
		},
	},
	settings = {
		-- ref: https://github.com/rust-lang/rust-analyzer/issues/6905#issuecomment-1594331006
		-- ref: https://raw.githubusercontent.com/rust-analyzer/rust-analyzer/master/editors/code/package.json
		["rust-analyzer"] = {
			check = {
				command = "clippy", -- enable clippy
			},
			diagnostics = {
				experimental = {
					enable = true,
				},
			},
			cargo = {
				allTargets = false,
				features = "all",
				buildScripts = {
					enable = true,
				},
			},
			procMacro = {
				enable = true,
			},
			imports = {
				granularity = {
					group = "module",
				},
				prefix = "self",
			},
		},
	},
}

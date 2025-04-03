return {
	settings = {
		-- ref: https://github.com/rust-lang/rust-analyzer/issues/6905#issuecomment-1594331006
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

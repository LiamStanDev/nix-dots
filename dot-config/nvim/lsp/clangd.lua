return {
	cmd = {
		"clangd",
		"--background-index", -- make background index for quick jump into definition
		"--clang-tidy", -- linter
		"--cross-file-rename",
		"--completion-style=detailed", -- more info when completion popup
		"--header-insertion=iwyu", -- header only insert `include whay you use`
		"--header-insertion-decorators", -- show header insert in completion
		"--function-arg-placeholders",
		"--fallback-style=Google",
		"--offset-encoding=utf-16",
	},
	root_markers = {
		".clangd",
		".clang-tidy",
		".clang-format",
		"compile_commands.json",
		"compile_flags.txt",
		".git",
	},
	filetypes = { "c", "cc", "cpp", "objc", "objcpp", "cuda" },
}

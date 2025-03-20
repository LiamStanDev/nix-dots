local clangd_config = {
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
	init_options = { compilationDatabasePath = "./build" },
	filetypes = { "c", "cc", "cpp", "objc", "objcpp", "cuda" },
}

if vim.fn.isdirectory("build") == 1 then
	clangd_config.init_options = { compilationDatabasePath = "./build" }
	return clangd_config
end

return clangd_config

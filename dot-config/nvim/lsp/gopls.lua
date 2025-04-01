return {
	cmd = { "gopls" },
	root_markers = {
		"CMakePresets.json",
		"CTestConfig.cmake",
		".git",
		"build",
		"cmake",
	},
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_markers = {
		"go.work",
		"go.mod",
		".git",
	},
}

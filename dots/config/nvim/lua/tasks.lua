-- task-runner

local function cpp_build_single_file()
	local command = "g++ -g -o ./a.out -std=c++20 "
	command = command .. vim.api.nvim_buf_get_name(0)
	return command
end

local function run_python_file()
	local command = "uv run "
	command = command .. vim.api.nvim_buf_get_name(0)
	return command
end

local function run_by_node()
	local command = "node "
	command = command .. vim.api.nvim_buf_get_name(0)
	return command
end

return {
	cpp_cmake = {
		{
			label = "Config",
			command = "icpp config debug",
		},
		{
			label = "Config (Release)",
			command = "icpp config release",
		},
		{ label = "Run Tests", command = "icpp test" },
		{ label = "Build", command = "icpp build" },
		{ label = "CMake Install", command = "icpp install" },
		{ label = "Run", command = "cmake --build build --target run" },
	},
	cpp = {
		{ label = "Run Single File", command = cpp_build_single_file() .. " &&./a.out" },
		{ label = "Build Single File", command = cpp_build_single_file() },
		{ label = "Clang Format Init", command = "clang-format --style=Google -dump-config > .clang-format" },
	},
	python = {
		{ label = "Run Script", command = run_python_file() },
		{ label = "Run Tests", command = "uvx pytest" },
		{ label = "Init Project", command = "uv init" },
		{ label = "Sync", command = "uv sync" },
	},
	rust = {
		{ label = "Check", command = "cargo check" },
		{ label = "Build", command = "cargo build" },
		{ label = "Run", command = "cargo run" },
		{ label = "Test", command = "cargo test" },
	},
	js = {
		{ label = "Run(node)", command = run_by_node() },
	},
}

local M = {}

--- Detects the type of project based on the presence of specific files or the filetype.
-- @return A string representing the project type (e.g., "cpp_cmake", "python", "rust"), or nil if no type is detected.
local function detect_project_type()
	local filetype = vim.bo.filetype
	if vim.fn.filereadable("CMakeLists.txt") == 1 then
		return "cpp_cmake"
	elseif filetype == "cpp" then
		return "cpp"
	elseif
		vim.fn.filereadable("pyproject.toml") == 1
		or vim.fn.filereadable("setup.py") == 1
		or vim.fn.filereadable("requirements.txt") == 1
		or filetype == "python"
	then
		return "python"
	elseif
		vim.fn.filereadable("Cargo.toml") == 1
		or vim.fn.filereadable("src/main.rs") == 1
		or vim.fn.filereadable("src/lib.rs") == 1
	then
		return "rust"
	elseif vim.fn.filereadable("package.json") == 1 then
		return "javascript"
	elseif vim.fn.filereadable("go.mod") == 1 or filetype == "go" then
		return "go"
	elseif vim.fn.filereadable("pom.xml") == 1 or vim.fn.filereadable("build.gradle") == 1 or filetype == "java" then
		return "java"
	else
		return nil
	end
end

--- Opens a task selection menu based on the detected project type.
-- Uses `vim.ui.select` to display available tasks and executes the selected task in a terminal.
function M.open_task_menu()
	local project_type = detect_project_type() or ""
	local tasks = require("tasks")[project_type] or {}
	if #tasks == 0 then
		vim.notify("No tasks available for project type: " .. project_type, vim.log.levels.WARN)
		return
	end

	local entries = {}
	for _, task in ipairs(tasks) do
		table.insert(entries, { label = task.label, command = task.command })
	end

	-- Use `vim.ui.select` to display the task menu.
	vim.ui.select(entries, {
		prompt = "Select Task",
		format_item = function(item)
			return item.label
		end,
	}, function(selected, _)
		if selected then
			local user_cmd = vim.fn.input("command: ", selected.command)
			local dir = vim.fn.getcwd()
			Snacks.terminal.open(user_cmd, {
				cwd = dir,
				auto_close = false,
				win = {
					on_win = function(self)
						local footer_msg = ""
						if self.cmd then
							if type(self.cmd) == "table" then
								footer_msg = "Running command: " .. table.concat(self.cmd, " ")
							else
								footer_msg = "Running command: " .. tostring(self.cmd)
							end
						end
						vim.api.nvim_win_set_config(
							self.win,
							{ title = "Task Runner", title_pos = "center", footer = footer_msg }
						)
					end,
				},
			})
		end
	end)
end

--- Synchronous version of `vim.ui.select` using coroutines.
-- Waits for the user to make a selection and returns the selected item.
-- @param items A list of items to display in the selection menu.
-- @param opts Configuration options for `vim.ui.select`.
-- @return The selected item, or nil if the selection is canceled.
function M.select_sync(items, opts)
	if #items == 1 then
		return items[1]
	end

	-- Check if already running in a coroutine.
	local co = coroutine.running()
	if not co then
		-- If not in a coroutine, create one and execute.
		local selected
		co = coroutine.create(function()
			selected = M.select_sync(items, opts)
		end)
		coroutine.resume(co)
		return selected
	end

	-- In a coroutine, wait for the selection to complete.
	vim.ui.select(items, opts, function(choice)
		vim.schedule(function()
			coroutine.resume(co, choice)
		end)
	end)

	-- Pause the coroutine until a selection is made.
	return coroutine.yield()
end

function M.load_saved_chat()
	local history_dir = vim.fn.stdpath("data") .. "/copilotchat_history"
	local files = {}
	local scan = vim.loop.fs_scandir(history_dir)
	if not scan then
		vim.notify("No saved chat history found in " .. history_dir)
		return
	end
	while true do
		local name, type = vim.loop.fs_scandir_next(scan)
		if not name then
			break
		end
		if type == "file" then
			local file_path = history_dir .. "/" .. name
			local stat = vim.loop.fs_stat(file_path)
			if stat then
				table.insert(files, { name = name, path = file_path, mtime = stat.mtime.sec })
			end
		end
	end
	table.sort(files, function(a, b)
		return a.mtime > b.mtime
	end)
	local choices = {}
	for _, file in ipairs(files) do
		table.insert(choices, file.name)
	end
	vim.ui.select(choices, { prompt = "Select chat to load:" }, function(choice)
		if choice then
			vim.cmd("CopilotChatLoad " .. choice)
		end
	end)
end

return M

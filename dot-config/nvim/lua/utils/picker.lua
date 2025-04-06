local M = {}

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

function M.open_task_menu()
	local project_type = detect_project_type() or ""
	-- vim.notify("Project type: " .. project_type)
	local tasks = require("tasks")[project_type] or {}
	if #tasks == 0 then
		vim.notify("No tasks available for project type: " .. project_type, vim.log.levels.WARN)
		return
	end

	local entries = {}
	for _, task in ipairs(tasks) do
		table.insert(entries, { label = task.label, command = task.command })
	end

	-- use vim.ui.select
	vim.ui.select(entries, {
		prompt = "Select Task",
		format_item = function(item)
			return item.label
		end,
	}, function(selected, _)
		if selected then
			local user_cmd = vim.fn.input("command: ", selected.command)
			local dir = vim.fn.getcwd()
			Snacks.terminal.open(user_cmd, { cwd = dir, auto_close = false })
		end
	end)
end

-- 同步版本的 vim.ui.select，使用協程實現等待用戶選擇
-- @param items 選項列表
-- @param opts 配置選項，與 vim.ui.select 相同
-- @return 用戶選擇的項目或 nil（如果取消）
function M.select_sync(items, opts)
	if #items == 1 then
		return items[1]
	end

	-- 檢查當前是否已經在協程中運行
	local co = coroutine.running()
	if not co then
		-- 如果不在協程中，創建一個新協程執行
		local selected
		co = coroutine.create(function()
			selected = M.select_sync(items, opts)
		end)
		coroutine.resume(co)
		return selected
	end

	-- 在協程中，等待選擇完成
	vim.ui.select(items, opts, function(choice)
		vim.schedule(function()
			coroutine.resume(co, choice)
		end)
	end)

	-- 暫停協程等待選擇
	return coroutine.yield()
end

return M

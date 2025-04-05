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

	-- Snacks.picker.pick({
	-- 	title = "Tasks",
	-- 	items = entries,
	-- 	source = "select",
	-- 	layout = {
	-- 		preview = false,
	-- 		layout = {
	-- 			height = math.floor(math.min(vim.o.lines * 0.8 - 10, #entries + 2) + 0.5),
	-- 		},
	-- 	},
	-- 	on_show = function()
	-- 		vim.cmd.stopinsert()
	-- 	end,
	-- 	actions = {
	-- 		confirm = function(picker, item)
	-- 			picker:close()
	-- 			vim.schedule(function()
	-- 				local user_cmd = vim.fn.input("command: ", item.command)
	-- 				local dir = vim.fn.getcwd()
	-- 				Snacks.terminal.open(user_cmd, { cwd = dir, auto_close = false })
	-- 			end)
	-- 		end,
	-- 	},
	-- })

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

---@generic T
---@param items T[] Arbitrary items
---@param opts? {prompt?: string, format_item?: (fun(item: T): string), kind?: string}
---@param on_choice fun(item?: T, idx?: number)
local function select(items, opts, on_choice)
	assert(type(on_choice) == "function", "on_choice must be a function")
	opts = opts or {}

	---@type snacks.picker.finder.Item[]
	local finder_items = {}
	for idx, item in ipairs(items) do
		local text = (opts.format_item or tostring)(item)
		table.insert(finder_items, {
			formatted = text,
			text = idx .. " " .. text,
			item = item,
			idx = idx,
		})
	end

	local title = opts.prompt or "Select"
	title = title:gsub("^%s*", ""):gsub("[%s:]*$", "")
	local completed = false

	---@type snacks.picker.finder.Item[]
	return Snacks.picker.pick({
		source = "select",
		items = finder_items,
		format = Snacks.picker.format.ui_select(opts.kind, #items),
		title = title,
		layout = {
			preview = false,
			layout = {
				height = math.floor(math.min(vim.o.lines * 0.8 - 10, #items + 2) + 0.5),
			},
		},
		actions = {
			confirm = function(picker, item)
				if completed then
					return
				end
				completed = true
				picker:close()
				vim.schedule(function()
					on_choice(item and item.item, item and item.idx)
				end)
			end,
		},
		on_show = function()
			vim.cmd.stopinsert()
		end,
		on_close = function()
			if completed then
				return
			end
			completed = true
			vim.schedule(on_choice)
		end,
	})
end

function M.setup_ui_select()
	vim.ui.select = select
end

return M

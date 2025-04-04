local M = {}

M.get_cs_dll = function()
	vim.fn.jobstart("dotnet build")
	return coroutine.create(function(dap_run_co)
		local items = vim.fn.globpath(vim.fn.getcwd(), "**/bin/Debug/**/*.dll", 0, 1)
		local opts = {
			format_item = function(path)
				return vim.fn.fnamemodify(path, ":t")
			end,
		}
		local function cont(choice)
			if choice == nil then
				return nil
			else
				coroutine.resume(dap_run_co, choice)
			end
		end

		vim.ui.select(items, opts, cont)
	end)
end

M.get_file = function()
	local path = vim.fn.input({
		prompt = "Path to executable: ",
		default = vim.fn.getcwd() .. "/",
		completion = "file",
	})
	return (path and path ~= "") and path or dap.ABORT
end

M.get_rust_bin = function()
	vim.fn.jobstart("cargo build")
	return coroutine.create(function(dap_run_co)
		local items = vim.fn.globpath(vim.fn.getcwd(), "**/target/debug/*", 0, 1)
		local opts = {
			format_item = function(path)
				return vim.fn.fnamemodify(path, ":t")
			end,
		}
		local function cont(choice)
			if choice == nil then
				return nil
			else
				coroutine.resume(dap_run_co, choice)
			end
		end
		vim.ui.select(items, opts, cont)
	end)
end

-- M.get_port = function()
-- 	return coroutine.create(function(dap_run_co)
-- 		local cmd = "ss -tln"
-- 		-- open read mode
-- 		local handle = io.popen(cmd, "r")
-- 		local running_ports = {}
--
-- 		for line in handle:lines() do
-- 			local port = string.match(line, ":(%d+)")
-- 			if port then
-- 				table.insert(running_ports, tonumber(port))
-- 			end
-- 		end
--
-- 		handle:close()
--
-- 		local opts = {
-- 			prompt = "Select a running port:",
-- 		}
--
-- 		local function cont(choice)
-- 			if choice == nil then
-- 				return nil
-- 			else
-- 				coroutine.resume(dap_run_co, choice)
-- 			end
-- 		end
--
-- 		vim.ui.select(running_ports, opts, cont)
-- 	end)
-- end

return M

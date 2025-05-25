local ra = require("utils.rust_analyzer")
local util = require("utils.lsp")

local function reload_worspace(bufnr)
	local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "rust_analyzer" })
	for _, client in ipairs(clients) do
		vim.notify("Reloading Cargo Workspace", vim.log.levels.INFO)
		client:request("rust-analyzer/reloadWorkspace", nil, function(err)
			if err then
				error(tostring(err))
			end
			vim.notify("Cargo workspace reloaded")
		end, 0)
	end
end

local function is_library(fname)
	local user_home = vim.fs.normalize(vim.env.HOME)
	local cargo_home = os.getenv("CARGO_HOME") or user_home .. "/.cargo"
	local registry = cargo_home .. "/registry/src"
	local git_registry = cargo_home .. "/git/checkouts"

	local rustup_home = os.getenv("RUSTUP_HOME") or user_home .. "/.rustup"
	local toolchains = rustup_home .. "/toolchains"

	for _, item in ipairs({ toolchains, registry, git_registry }) do
		if vim.fs.relpath(item, fname) then
			local clients = vim.lsp.get_clients({ name = "rust_analyzer" })
			return #clients > 0 and clients[#clients].config.root_dir or nil
		end
	end
end

return {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
	root_dir = function(bufnr, on_dir)
		local fname = vim.api.nvim_buf_get_name(bufnr)
		local reused_dir = is_library(fname)
		if reused_dir then
			on_dir(reused_dir)
			return
		end

		local cargo_crate_dir = util.root_pattern("Cargo.toml")(fname)
		local cargo_workspace_root

		if cargo_crate_dir == nil then
			on_dir(
				util.root_pattern("rust-project.json")(fname)
					or vim.fs.dirname(vim.fs.find(".git", { path = fname, upward = true })[1])
			)
			return
		end

		local cmd = {
			"cargo",
			"metadata",
			"--no-deps",
			"--format-version",
			"1",
			"--manifest-path",
			cargo_crate_dir .. "/Cargo.toml",
		}

		vim.system(cmd, { text = true }, function(output)
			if output.code == 0 then
				if output.stdout then
					local result = vim.json.decode(output.stdout)
					if result["workspace_root"] then
						cargo_workspace_root = vim.fs.normalize(result["workspace_root"])
					end
				end

				on_dir(cargo_workspace_root or cargo_crate_dir)
			else
				vim.notify(("[rust_analyzer] cmd failed with code %d: %s\n%s"):format(output.code, cmd, output.stderr))
			end
		end)
	end,
	capabilities = {
		experimental = {
			colorDiagnosticOutput = true, -- Enable colorized diagnostic output.
			serverStatusNotification = true, -- Enable server status notifications.
		},
		textDocument = {
			completion = {
				completionItem = {
					resolveSupport = {
						properties = { "documentation", "detail", "additionalTextEdits" },
					},
				},
			},
		},
	},
	settings = {
		-- ref: https://rust-analyzer.github.io/book/configuration.html
		["rust-analyzer"] = {
			check = {
				enabled = true,
				command = "clippy", -- Use Clippy for linting.
				features = "all",
				-- extraArgs = { "--no-deps" }, -- Only check/analyze your project's own code
			},
			checkOnSave = true,
			cargo = {
				allTargets = false, -- Do not check all targets by default.
				features = "all", -- Enable all features.
				buildScripts = {
					enable = true, -- Enable build script support.
				},
			},
			procMacro = {
				enable = true, -- Enable procedural macros.
				ignored = {
					["async-trait"] = { "async_trait" },
					["napi-derive"] = { "napi" },
					["async-recursion"] = { "async_recursion" },
				},
				attributes = {
					enable = { "*" },
				},
			},
			imports = {
				granularity = {
					group = "module", -- Group imports by module.
				},
				prefix = "self", -- Use `self` as the import prefix.
			},
			files = {
				excludeDirs = {
					".direnv",
					".git",
					".github",
					".gitlab",
					"bin",
					"node_modules",
					"target",
					"venv",
					".venv",
				},
			},
		},
	},
}

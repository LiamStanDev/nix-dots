local M = {}

local function escape_wildcards(path)
	return path:gsub("([%[%]%?%*])", "\\%1")
end

--- Appends all elements from the second list to the first list.
-- @param list1 The first list to which elements will be appended.
-- @param list2 The second list whose elements will be appended to the first list.
function M.append_lists(list1, list2)
	for _, value in ipairs(list2) do
		table.insert(list1, value)
	end
end

function M.tbl_flatten(t)
	-- math.huge is used to flatten all levels of the table
	return vim.iter(t):flatten(math.huge):totable()
end

--- Creates a root directory detection function that looks for files matching the given patterns.
--- @param ... string[] Pattern(s) to search for (e.g. '.git', 'Cargo.toml')
--- @return function # Returns a function that takes a start path and returns the matched root path
function M.root_pattern(...)
	local patterns = M.tbl_flatten({ ... })

	return function(startpath)
		startpath = M.strip_archive_subpath(startpath)
		for _, pattern in ipairs(patterns) do
			local match = M.search_ancestors(startpath, function(path)
				for _, p in ipairs(vim.fn.glob(table.concat({ escape_wildcards(path), pattern }, "/"), true, true)) do
					if vim.uv.fs_stat(p) then
						return path
					end
				end
			end)

			if match ~= nil then
				return match
			end
		end
	end
end

--- Retrieves a list of unique service identifiers based on the provided configuration.
-- This includes LSP servers, formatters, linters, and DAP servers.
-- @param config A table containing configuration for LSP servers, formatters, linters, and DAP servers.
-- @return A list of unique service identifiers.
function M.get_service_identifiers(config)
	local utils = require("utils.lsp")
	local packages = {}
	local packages_seen = {}

	-- Add LSP servers
	for _, server in ipairs(config.lsp_servers) do
		local pkg = utils.lspconfig_to_package[server]
		if pkg and not packages_seen[pkg] then
			table.insert(packages, pkg)
			packages_seen[pkg] = true
		end
	end

	-- Add formatter services
	for _, servers in pairs(config.formatters) do
		for _, server in ipairs(servers) do
			if type(server) == "string" then
				local pkg = utils.conform_to_package[server]
				if pkg and not packages_seen[pkg] then
					table.insert(packages, pkg)
					packages_seen[pkg] = true
				end
			end
		end
	end

	-- Add linting services
	for _, servers in pairs(config.linters) do
		for _, server in ipairs(servers) do
			local pkg = utils.nvimlint_to_pakcage[server]
			if pkg and not packages_seen[pkg] then
				table.insert(packages, pkg)
				packages_seen[pkg] = true
			end
		end
	end

	-- Add DAP servers
	for _, server in ipairs(config.dap_servers) do
		local pkg = utils.dap_to_package[server]
		if pkg and not packages_seen[pkg] then
			table.insert(packages, pkg)
			packages_seen[pkg] = true
		end
	end
	return packages
end

function M.build_default_capacities()
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	-- nvim ufo
	capabilities.textDocument.foldingRange = {
		dynamicRegistration = false,
		lineFoldingOnly = true,
	}

	-- lsp quick start
	capabilities.textDocument = {
		semanticTokens = {
			multilineTokenSupport = true,
		},
	}
	capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)
end

function M.strip_archive_subpath(path)
	-- Matches regex from zip.vim / tar.vim
	path = vim.fn.substitute(path, "zipfile://\\(.\\{-}\\)::[^\\\\].*$", "\\1", "")
	path = vim.fn.substitute(path, "tarfile:\\(.\\{-}\\)::.*$", "\\1", "")
	return path
end

function M.search_ancestors(startpath, func)
	if nvim_eleven then
		validate("func", func, "function")
	end
	if func(startpath) then
		return startpath
	end
	local guard = 100
	for path in vim.fs.parents(startpath) do
		-- Prevent infinite recursion if our algorithm breaks
		guard = guard - 1
		if guard == 0 then
			return
		end

		if func(path) then
			return path
		end
	end
end

--- Mapping of LSP server names to their corresponding package names.
M.lspconfig_to_package = {
	["angularls"] = "angular-language-server",
	["ansiblels"] = "ansible-language-server",
	["antlersls"] = "antlers-language-server",
	["apex_ls"] = "apex-language-server",
	["arduino_language_server"] = "arduino-language-server",
	["asm_lsp"] = "asm-lsp",
	["ast_grep"] = "ast-grep",
	["astro"] = "astro-language-server",
	["autotools_ls"] = "autotools-language-server",
	["awk_ls"] = "awk-language-server",
	["azure_pipelines_ls"] = "azure-pipelines-language-server",
	["basedpyright"] = "basedpyright",
	["bashls"] = "bash-language-server",
	["beancount"] = "beancount-language-server",
	["bicep"] = "bicep-lsp",
	["biome"] = "biome",
	["bright_script"] = "brighterscript",
	["bsl_ls"] = "bsl-language-server",
	["buf_ls"] = "buf",
	["bzl"] = "bzl",
	["cairo_ls"] = "cairo-language-server",
	["clangd"] = "clangd",
	["clarity_lsp"] = "clarity-lsp",
	["clojure_lsp"] = "clojure-lsp",
	["cmake"] = "cmake-language-server",
	["cobol_ls"] = "cobol-language-support",
	["codeqlls"] = "codeql",
	["coq_lsp"] = "coq-lsp",
	["crystalline"] = "crystalline",
	["csharp_ls"] = "csharp-language-server",
	["cssls"] = "css-lsp",
	["cssmodules_ls"] = "cssmodules-language-server",
	["css_variables"] = "css-variables-language-server",
	["cucumber_language_server"] = "cucumber-language-server",
	["custom_elements_ls"] = "custom-elements-languageserver",
	["cypher_ls"] = "cypher-language-server",
	["dagger"] = "cuelsp",
	["denols"] = "deno",
	["dhall_lsp_server"] = "dhall-lsp",
	["diagnosticls"] = "diagnostic-languageserver",
	["docker_compose_language_service"] = "docker-compose-language-service",
	["dockerls"] = "dockerfile-language-server",
	["dotls"] = "dot-language-server",
	["dprint"] = "dprint",
	["drools_lsp"] = "drools-lsp",
	["earthlyls"] = "earthlyls",
	["efm"] = "efm",
	["elixirls"] = "elixir-ls",
	["elmls"] = "elm-language-server",
	["elp"] = "elp",
	["ember"] = "ember-language-server",
	["emmet_language_server"] = "emmet-language-server",
	["emmet_ls"] = "emmet-ls",
	["erg_language_server"] = "erg-language-server",
	["erlangls"] = "erlang-ls",
	["esbonio"] = "esbonio",
	["eslint"] = "eslint-lsp",
	["facility_language_server"] = "facility-language-server",
	["fennel_language_server"] = "fennel-language-server",
	["fennel_ls"] = "fennel-ls",
	["flux_lsp"] = "flux-lsp",
	["foam_ls"] = "foam-language-server",
	["fortls"] = "fortls",
	["fsautocomplete"] = "fsautocomplete",
	["gitlab_ci_ls"] = "gitlab-ci-ls",
	["ginko_ls"] = "ginko_ls",
	["glint"] = "glint",
	["glsl_analyzer"] = "glsl_analyzer",
	["glslls"] = "glslls",
	["golangci_lint_ls"] = "golangci-lint-langserver",
	["gopls"] = "gopls",
	["gradle_ls"] = "gradle-language-server",
	["grammarly"] = "grammarly-languageserver",
	["graphql"] = "graphql-language-service-cli",
	["groovyls"] = "groovy-language-server",
	["harper_ls"] = "harper-ls",
	["haxe_language_server"] = "haxe-language-server",
	["hdl_checker"] = "hdl-checker",
	["helm_ls"] = "helm-ls",
	["hls"] = "haskell-language-server",
	["hoon_ls"] = "hoon-language-server",
	["html"] = "html-lsp",
	["htmx"] = "htmx-lsp",
	["hydra_lsp"] = "hydra-lsp",
	["hyprls"] = "hyprls",
	["intelephense"] = "intelephense",
	["java_language_server"] = "java-language-server",
	["jdtls"] = "jdtls",
	["jedi_language_server"] = "jedi-language-server",
	["jinja_lsp"] = "jinja-lsp",
	["jqls"] = "jq-lsp",
	["jsonls"] = "json-lsp",
	["jsonnet_ls"] = "jsonnet-language-server",
	["julials"] = "julia-lsp",
	["kcl"] = "kcl",
	["kotlin_language_server"] = "kotlin-language-server",
	["lelwel_ls"] = "lelwel",
	["lemminx"] = "lemminx",
	["lexical"] = "lexical",
	["ltex"] = "ltex-ls",
	["lua_ls"] = "lua-language-server",
	["luau_lsp"] = "luau-lsp",
	["lwc_ls"] = "lwc-language-server",
	["markdown_oxide"] = "markdown-oxide",
	["marksman"] = "marksman",
	["matlab_ls"] = "matlab-language-server",
	["mdx_analyzer"] = "mdx-analyzer",
	["millet"] = "millet",
	["mm0_ls"] = "metamath-zero-lsp",
	["motoko_lsp"] = "motoko-lsp",
	["move_analyzer"] = "move-analyzer",
	["mutt_ls"] = "mutt-language-server",
	["neocmake"] = "neocmakelsp",
	["nextls"] = "nextls",
	["nickel_ls"] = "nickel-lang-lsp",
	["nginx_language_server"] = "nginx-language-server",
	["nil_ls"] = "nil",
	["nim_langserver"] = "nimlangserver",
	["nimls"] = "nimlsp",
	["ocamllsp"] = "ocaml-lsp",
	["ols"] = "ols",
	["omnisharp"] = "omnisharp",
	["omnisharp_mono"] = "omnisharp-mono",
	["opencl_ls"] = "opencl-language-server",
	["openscad_lsp"] = "openscad-lsp",
	["pbls"] = "pbls",
	["perlnavigator"] = "perlnavigator",
	["pest_ls"] = "pest-language-server",
	["phpactor"] = "phpactor",
	["pico8_ls"] = "pico8-ls",
	["pkgbuild_language_server"] = "pkgbuild-language-server",
	["powershell_es"] = "powershell-editor-services",
	["prismals"] = "prisma-language-server",
	["prosemd_lsp"] = "prosemd-lsp",
	["psalm"] = "psalm",
	["puppet"] = "puppet-editor-services",
	["purescriptls"] = "purescript-language-server",
	["pylsp"] = "python-lsp-server",
	["pylyzer"] = "pylyzer",
	["pyre"] = "pyre",
	["pyright"] = "pyright",
	["quick_lint_js"] = "quick-lint-js",
	["r_language_server"] = "r-languageserver",
	["raku_navigator"] = "raku-navigator",
	["reason_ls"] = "reason-language-server",
	["regols"] = "regols",
	["regal"] = "regal",
	["remark_ls"] = "remark-language-server",
	["rescriptls"] = "rescript-language-server",
	["rnix"] = "rnix-lsp",
	["robotframework_ls"] = "robotframework-lsp",
	["rome"] = "rome",
	["rubocop"] = "rubocop",
	["ruby_lsp"] = "ruby-lsp",
	["ruff"] = "ruff",
	["rust_analyzer"] = "rust-analyzer",
	["salt_ls"] = "salt-lsp",
	["serve_d"] = "serve-d",
	["shopify_theme_ls"] = "shopify-cli",
	["slint_lsp"] = "slint-lsp",
	["smithy_ls"] = "smithy-language-server",
	["snakeskin_ls"] = "snakeskin-cli",
	["snyk_ls"] = "snyk-ls",
	["solang"] = "solang",
	["solargraph"] = "solargraph",
	["solc"] = "solidity",
	["solidity"] = "solidity-ls",
	["solidity_ls"] = "vscode-solidity-server",
	["solidity_ls_nomicfoundation"] = "nomicfoundation-solidity-language-server",
	["somesass_ls"] = "some-sass-language-server",
	["sorbet"] = "sorbet",
	["sourcery"] = "sourcery",
	["spectral"] = "spectral-language-server",
	["sqlls"] = "sqlls",
	["sqls"] = "sqls",
	["standardrb"] = "standardrb",
	["starlark_rust"] = "starlark-rust",
	["starpls"] = "starpls",
	["steep"] = "steep",
	["stimulus_ls"] = "stimulus-language-server",
	["stylelint_lsp"] = "stylelint-lsp",
	["svelte"] = "svelte-language-server",
	["svlangserver"] = "svlangserver",
	["svls"] = "svls",
	["swift_mesonls"] = "swift-mesonlsp",
	["mesonlsp"] = "mesonlsp",
	["tailwindcss"] = "tailwindcss-language-server",
	["taplo"] = "taplo",
	["teal_ls"] = "teal-language-server",
	["templ"] = "templ",
	["terraformls"] = "terraform-ls",
	["texlab"] = "texlab",
	["textlsp"] = "textlsp",
	["tflint"] = "tflint",
	["theme_check"] = "shopify-theme-check",
	["thriftls"] = "thriftls",
	["ts_ls"] = "typescript-language-server",
	["tsp_server"] = "tsp-server",
	["twiggy_language_server"] = "twiggy-language-server",
	["typos_lsp"] = "typos-lsp",
	["tinymist"] = "tinymist",
	["unocss"] = "unocss-language-server",
	["v_analyzer"] = "v-analyzer",
	["vacuum"] = "vacuum",
	["vala_ls"] = "vala-language-server",
	["vale_ls"] = "vale-ls",
	["verible"] = "verible",
	["veryl_ls"] = "veryl-ls",
	["vhdl_ls"] = "rust_hdl",
	["vimls"] = "vim-language-server",
	["visualforce_ls"] = "visualforce-language-server",
	["vls"] = "vls",
	["volar"] = "vue-language-server",
	["vtsls"] = "vtsls",
	["vuels"] = "vetur-vls",
	["wgsl_analyzer"] = "wgsl-analyzer",
	["yamlls"] = "yaml-language-server",
	["zk"] = "zk",
	["zls"] = "zls",
}

--- Mapping of formatter names to their corresponding package names.
M.conform_to_package = {
	-- alejandra
	["asmfmt"] = "asmfmt",
	["ast-grep"] = "ast-grep",
	-- astyle
	-- auto_optional
	-- autocorrect
	["autoflake"] = "autoflake",
	["autopep8"] = "autopep8",
	-- awk
	-- bean-format
	["beautysh"] = "beautysh",
	["bibtex-tidy"] = "bibtex-tidy",
	-- biome-check
	["biome"] = "biome",
	["black"] = "black",
	["blade-formatter"] = "blade-formatter",
	["blue"] = "blue",
	["buf"] = "buf",
	["buildifier"] = "buildifier",
	["cbfmt"] = "cbfmt",
	["clang-format"] = "clang-format",
	-- cljstyle
	["cmake_format"] = "cmakelang",
	["codespell"] = "codespell",
	["csharpier"] = "csharpier",
	-- cue_fmt
	["darker"] = "darker",
	-- dart_format
	["deno_fmt"] = "deno",
	-- dfmt
	["djlint"] = "djlint",
	["dprint"] = "dprint",
	["easy-coding-standard"] = "easy-coding-standard",
	["elm_format"] = "elm-format",
	-- erb_format
	["eslint_d"] = "eslint_d",
	["fantomas"] = "fantomas",
	-- fish_indent
	["fixjson"] = "fixjson",
	-- fnlfmt
	["fourmolu"] = "fourmolu",
	["gci"] = "gci",
	["gdformat"] = "gdtoolkit",
	["gersemi"] = "gersemi",
	-- gn
	-- gofmt
	["gofumpt"] = "gofumpt",
	["goimports-reviser"] = "goimports-reviser",
	["goimports"] = "goimports",
	["golines"] = "golines",
	["google-java-format"] = "google-java-format",
	["htmlbeautifier"] = "htmlbeautifier",
	-- indent
	-- init
	-- injected
	["isort"] = "isort",
	["joker"] = "joker",
	["jq"] = "jq",
	["jsonnetfmt"] = "jsonnetfmt",
	-- just
	["ktlint"] = "ktlint",
	["latexindent"] = "latexindent",
	["markdown-toc"] = "markdown-toc",
	["markdownlint-cli2"] = "markdownlint-cli2",
	["markdownlint"] = "markdownlint",
	["mdformat"] = "mdformat",
	["mdslw"] = "mdslw",
	-- mix
	-- nixfmt
	["nixpkgs_fmt"] = "nixpkgs-fmt",
	["ocamlformat"] = "ocamlformat",
	["opa_fmt"] = "opa",
	-- packer_fmt
	-- pangu
	-- perlimports
	-- perltidy
	-- pg_format
	["php_cs_fixer"] = "php-cs-fixer",
	["phpcbf"] = "phpcbf",
	-- phpinsights
	["pint"] = "pint",
	["prettier"] = "prettier",
	["prettierd"] = "prettierd",
	["pretty-php"] = "pretty-php",
	-- puppet-lint
	["reorder-python-imports"] = "reorder-python-imports",
	-- rescript-format
	["rubocop"] = "rubocop",
	["rubyfmt"] = "rubyfmt",
	-- ruff
	["ruff_fix"] = "ruff",
	["ruff_format"] = "ruff",
	["rufo"] = "rufo",
	-- ["rustfmt"] = "rustfmt", Deprecated by mason
	["rustywind"] = "rustywind",
	-- scalafmt
	["shellcheck"] = "shellcheck",
	["shellharden"] = "shellharden",
	["shfmt"] = "shfmt",
	["sql_formatter"] = "sql-formatter",
	["sqlfluff"] = "sqlfluff",
	["sqlfmt"] = "sqlfmt",
	-- squeeze_blanks
	["standardjs"] = "standardjs",
	["standardrb"] = "standardrb",
	["stylelint"] = "stylelint",
	-- styler
	["stylua"] = "stylua",
	-- swift_format
	-- swiftformat
	["taplo"] = "taplo",
	["templ"] = "templ",
	-- terraform_fmt
	-- terragrunt_hclfmt
	["tlint"] = "tlint",
	-- trim_newlines
	-- trim_whitespace
	-- twig-cs-fixer
	["typos"] = "typos",
	-- typstfmt
	-- uncrustify
	["usort"] = "usort",
	["xmlformat"] = "xmlformatter",
	-- xmllint
	["yamlfix"] = "yamlfix",
	["yamlfmt"] = "yamlfmt",
	["yapf"] = "yapf",
	["yq"] = "yq",
	-- zigfmt
	["zprint"] = "zprint",
}

--- Mapping of linter names to their corresponding package names.
M.nvimlint_to_pakcage = {
	["actionlint"] = "actionlint",
	["ansible_lint"] = "ansible-lint",
	["buf_lint"] = "buf",
	["buildifier"] = "buildifier",
	["cbfmt"] = "cbfmt",
	["cfn_lint"] = "cfn-lint",
	["checkstyle"] = "checkstyle",
	["checkmake"] = "checkmake",
	["clj_kondo"] = "clj-kondo",
	["cmakelint"] = "cmakelint",
	["codespell"] = "codespell",
	["cpplint"] = "cpplint",
	["cspell"] = "cspell",
	["curlylint"] = "curlylint",
	["djlint"] = "djlint",
	["editorconfig-checker"] = "editorconfig-checker",
	["erb_lint"] = "erb-lint",
	["eslint_d"] = "eslint_d",
	["flake8"] = "flake8",
	["gdlint"] = "gdtoolkit",
	["golangcilint"] = "golangci-lint",
	["hadolint"] = "hadolint",
	["htmlhint"] = "htmlhint",
	["jsonlint"] = "jsonlint",
	["ktlint"] = "ktlint",
	["luacheck"] = "luacheck",
	["markdownlint"] = "markdownlint",
	["mypy"] = "mypy",
	["oxlint"] = "oxlint",
	["phpcs"] = "phpcs",
	["phpmd"] = "phpmd",
	["phpstan"] = "phpstan",
	["proselint"] = "proselint",
	["psalm"] = "psalm",
	["pydocstyle"] = "pydocstyle",
	["pylint"] = "pylint",
	["revive"] = "revive",
	["rstcheck"] = "rstcheck",
	["rubocop"] = "rubocop",
	["ruff"] = "ruff",
	["selene"] = "selene",
	["shellcheck"] = "shellcheck",
	["shellharden"] = "shellharden",
	["solhint"] = "solhint",
	["sqlfluff"] = "sqlfluff",
	["standardrb"] = "standardrb",
	["stylelint"] = "stylelint",
	["snyk_iac"] = "snyk",
	["tflint"] = "tflint",
	["tfsec"] = "tfsec",
	["trivy"] = "trivy",
	["vale"] = "vale",
	["vint"] = "vint",
	["vulture"] = "vulture",
	["write_good"] = "write-good",
	["yamllint"] = "yamllint",
}

--- Mapping of DAP server names to their corresponding package names.
M.dap_to_package = {
	["python"] = "debugpy",
	["cppdbg"] = "cpptools",
	["delve"] = "delve",
	["node2"] = "node-debug2-adapter",
	["chrome"] = "chrome-debug-adapter",
	["firefox"] = "firefox-debug-adapter",
	["php"] = "php-debug-adapter",
	["coreclr"] = "netcoredbg",
	["js"] = "js-debug-adapter",
	["codelldb"] = "codelldb",
	["bash"] = "bash-debug-adapter",
	["javadbg"] = "java-debug-adapter",
	["javatest"] = "java-test",
	["mock"] = "mockdebug",
	["puppet"] = "puppet-editor-services",
	["elixir"] = "elixir-ls",
	["kotlin"] = "kotlin-debug-adapter",
	["dart"] = "dart-debug-adapter",
	["haskell"] = "haskell-debug-adapter",
	["erlang"] = "erlang-debugger",
}

return M

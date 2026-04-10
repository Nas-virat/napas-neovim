-- JDTLS (Java LSP) configuration
local jdtls = require("jdtls")
local mason = require("mason-registry")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.env.HOME .. "/.config/nvim/jdtls-workspace/" .. project_name
local jdtls_path = mason.get_package("jdtls"):get_install_path()
local equinox_launcher_path = vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar")
local extend_cap = jdtls.extendedClientCapabilities
extend_cap.onCompletionItemSelectedCommand = "editor.action.triggerParameterHints"

vim.api.nvim_create_autocmd("FileType", {
	pattern = "java",
	callback = function()
		local opt = vim.opt
		opt.shiftwidth = 4 -- the number of spaces inserted for each indentation
		opt.tabstop = 4 -- insert 2 spaces for a tab
	end,
})

-- Needed for debugging
local bundles = {
	vim.fn.glob(
		vim.env.HOME .. "/.local/share/nvim/mason/share/java-debug-adapter/com.microsoft.java.debug.plugin.jar"
	),
}

-- Needed for running/debugging unit tests
vim.list_extend(
	bundles,
	vim.split(vim.fn.glob(1, vim.env.HOME .. "/.local/share/nvim/mason/share/java-test/*.jar"), "\n")
)

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {

	-- The command that starts the language server
	-- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
	cmd = {
		-- "/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home/bin/java",
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-javaagent:" .. vim.env.HOME .. "/.local/share/nvim/mason/share/jdtls/lombok.jar",
		"-Xmx4g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",

		-- Eclipse jdtls location
		"-jar",
		equinox_launcher_path,

		-- Linux configuration (change to config_mac_arm for macOS)
		"-configuration",
		vim.env.HOME .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
		"-data",
		workspace_dir,
	},

	-- This is the default if not provided, you can remove it. Or adjust as needed.
	-- One dedicated LSP server & client will be started per unique root_dir
	-- root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "pom.xml", "build.gradle" }),
	root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),

		-- Here you can configure eclipse.jdt.ls specific settings
		-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
		settings = {
			java = {
				-- Java home using SDKMAN
				home = vim.env.HOME .. "/.sdkman/candidates/java/17.0.14-jbr",
				eclipse = {
					downloadSources = true,
				},
				configuration = {
					updateBuildConfiguration = "interactive",
					-- Java runtimes using SDKMAN
					runtimes = {
						{
							name = "JavaSE-17",
							path = vim.env.HOME .. "/.sdkman/candidates/java/17.0.14-jbr",
						},
						{
							name = "JavaSE-21",
							path = vim.env.HOME .. "/.sdkman/candidates/java/21.0.7-jbr",
						},
					},
				},
			-- Decompiler (should have a decompiler bundle on init options)
			contentProvider = {
				preferred = "fernflower",
			},
			-- Inlay hint
			-- inlayhints = {
			--   parameterNames = {
			--     enabled = "all",
			--   },
			-- },
			maven = {
				downloadSources = true,
			},
			implementationsCodeLens = {
				enabled = true,
			},
			referencesCodeLens = {
				enabled = true,
			},
			references = {
				includeDecompiledSources = true,
			},
			signatureHelp = { enabled = true },
			format = {
				enabled = true,
				-- Formatting works by default, but you can refer to a specific file/URL if you choose
				settings = {
					-- url = "https://github.com/google/styleguide/blob/gh-pages/intellij-java-google-style.xml",
					session_file = "~/.config/nvim/formatconf/java-google-style.xml",
					-- url = "~/.config/nvim/formatconf/java-google-style.xml",
					profile = "GoogleStyle",
				},
			},
		},
		completion = {
			favoriteStaticMembers = {
				"org.hamcrest.MatcherAssert.assertThat",
				"org.hamcrest.Matchers.*",
				"org.hamcrest.CoreMatchers.*",
				"org.junit.jupiter.api.Assertions.*",
				"java.util.Objects.requireNonNull",
				"java.util.Objects.requireNonNullElse",
				"org.mockito.Mockito.*",
			},
			importOrder = {
				"java",
				"javax",
				"com",
				"org",
			},
		},
		extendedClientCapabilities = extend_cap,
		sources = {
			organizeImports = {
				starThreshold = 9999,
				staticStarThreshold = 9999,
			},
		},
		codeGeneration = {
			toString = {
				template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
			},
			useBlocks = true,
		},
	},
	-- Needed for auto-completion with method signatures and placeholders
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	flags = {
		allow_incremental_sync = true,
	},
	init_options = {
		-- References the bundles defined above to support Debugging and Unit Testing
		bundles = bundles,
	},
}

-- Add dap configurations based on your language/adapter settings
-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
require("dap").configurations.java = {
	{
		name = "Debug Launch (2GB)",
		type = "java",
		request = "launch",
		vmArgs = "" .. "-Xmx2g ",
	},
	{
		name = "Debug Attach (8000)",
		type = "java",
		request = "attach",
		hostName = "127.0.0.1",
		port = 8000,
	},
	{
		name = "Debug Attach (5005)",
		type = "java",
		request = "attach",
		hostName = "127.0.0.1",
		port = 5005,
	},
	{
		name = "My Custom Java Run Configuration",
		type = "java",
		request = "launch",
		-- You need to extend the classPath to list your dependencies.
		-- `nvim-jdtls` would automatically add the `classPaths` property if it is missing
		-- classPaths = {},

		-- If using multi-module projects, remove otherwise.
		-- projectName = "yourProjectName",

		-- javaExec = "java",
		mainClass = "replace.with.your.fully.qualified.MainClass",

		-- If using the JDK9+ module system, this needs to be extended
		-- `nvim-jdtls` would automatically populate this property
		-- modulePaths = {},
		vmArgs = "" .. "-Xmx2g ",
	},
}

config["on_attach"] = function(client, bufnr)
	local keymap = vim.keymap
	local opts = { buffer = bufnr, silent = true }

	jdtls.setup_dap({
		hotcodereplace = "auto",
		config_overrides = {},
	})
	require("jdtls.dap").setup_dap_main_class_configs()

	opts.desc = "Show LSP references"
	keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

	opts.desc = "Go to declaration"
	keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

	opts.desc = "Show LSP definitions"
	keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

	opts.desc = "Show LSP implementations"
	keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

	opts.desc = "Show LSP type definitions"
	keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

	opts.desc = "See available code actions"
	keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

	opts.desc = "Smart rename"
	keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

	opts.desc = "Show buffer diagnostics"
	keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

	opts.desc = "Show line diagnostics"
	keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

	opts.desc = "Go to previous diagnostic"
	keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

	opts.desc = "Go to next diagnostic"
	keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

	opts.desc = "Show documentation for what is under cursor"
	keymap.set("n", "K", vim.lsp.buf.hover, opts)

	opts.desc = "Restart LSP"
	keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

	opts.desc = "Organize imports"
	keymap.set("n", "<leader>jo", function()
		require("jdtls").organize_imports()
	end, opts)

	opts.desc = "Update project config"
	keymap.set("n", "<leader>juc", function()
		require("jdtls").update_projects_config()
	end, opts)

	opts.desc = "Test class"
	keymap.set("n", "<leader>jtc", function()
		require("jdtls").test_class()
	end, opts)

	opts.desc = "Test nearest method"
	keymap.set("n", "<leader>jtn", function()
		require("jdtls").test_nearest_method()
	end, opts)

	local springboot_nvim = require("springboot-nvim")
	keymap.set("n", "<leader>jr", springboot_nvim.boot_run, { desc = "Spring Boot Run Project" })
	keymap.set("n", "<leader>jc", springboot_nvim.generate_class, { desc = "Java Create Class" })
	keymap.set("n", "<leader>ji", springboot_nvim.generate_interface, { desc = "Java Create Interface" })
	keymap.set("n", "<leader>je", springboot_nvim.generate_enum, { desc = "Java Create Enum" })
	springboot_nvim.setup()
end

jdtls.start_or_attach(config)

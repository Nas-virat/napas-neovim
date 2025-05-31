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

		-- TODO Update this to point to the correct jdtls subdirectory for your OS (config_linux, config_mac, config_win, etc)
		"-configuration",
		vim.env.HOME .. "/.local/share/nvim/mason/packages/jdtls/config_mac_arm",
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
			-- TODO Replace this with the absolute path to your main java version (JDK 17 or higher)
			home = "/opt/homebrew/opt/openjdk@22/libexec/openjdk.jdk/Contents/Home",
			eclipse = {
				downloadSources = true,
			},
			configuration = {
				updateBuildConfiguration = "interactive",
				-- TODO Update this by adding any runtimes that you need to support your Java projects and removing any that you don't have installed
				-- The runtime name parameters need to match specific Java execution environments.  See https://github.com/tamago324/nlsp-settings.nvim/blob/2a52e793d4f293c0e1d61ee5794e3ff62bfbbb5d/schemas/_generated/jdtls.json#L317-L334
				runtimes = {
					{
						name = "JavaSE-11",
						path = "/opt/homebrew/opt/openjdk@11/libexec/openjdk.jdk/Contents/Home",
					},
					{
						name = "JavaSE-17",
						path = "/opt/homebrew/opt/openjdk@17/libexec/openjdk.jdk/Contents/Home",
					},
					{
						name = "JavaSE-21",
						path = "/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home",
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

-- Needed for debugging
config["on_attach"] = function(client, bufnr)
	jdtls.setup_dap({
		hotcodereplace = "auto",
		config_overrides = {
			-- cwd = ".",
			-- vmArgs = "",
			-- noDebug = false,
		},
	})
	require("jdtls.dap").setup_dap_main_class_configs()

	-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
	vim.keymap.set("n", "<leader>jo", function()
		if vim.bo.filetype == "java" then
			require("jdtls").organize_imports()
		end
	end)

	vim.keymap.set("n", "<leader>juc", function()
		if vim.bo.filetype == "java" then
			require("jdtls").update_projects_config()
		end
	end)

	vim.keymap.set("n", "<leader>jtc", function()
		if vim.bo.filetype == "java" then
			require("jdtls").test_class()
		end
	end)

	vim.keymap.set("n", "<leader>jtn", function()
		if vim.bo.filetype == "java" then
			require("jdtls").test_nearest_method()
		end
	end)

	local springboot_nvim = require("springboot-nvim")

	vim.keymap.set("n", "<leader>jr", springboot_nvim.boot_run, { desc = "Spring Boot Run Project" })
	vim.keymap.set("n", "<leader>jc", springboot_nvim.generate_class, { desc = "Java Create Class" })
	vim.keymap.set("n", "<leader>ji", springboot_nvim.generate_interface, { desc = "Java Create Interface" })
	vim.keymap.set("n", "<leader>je", springboot_nvim.generate_enum, { desc = "Java Create Enum" })
	springboot_nvim.setup()
end

-- This starts a new client & server, or attaches to an existing client & server based on the `root_dir`.
jdtls.start_or_attach(config)

return {
	"mason-org/mason-lspconfig.nvim",
	opts = {

		ensure_installed = {
			"html",
			"cssls",
			"tailwindcss",
			"emmet_ls",
			"lua_ls",
			"jdtls",
			"gopls",
			"bashls",
			"jsonls",
			"ast_grep",
			"pyright",
			"angularls",
			"markdown_oxide",
			"kotlin_language_server",
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"mason-org/mason-registry",
	},
	config = function()
		local tools = {
			"prettier", -- prettier formatter
			"stylua", -- lua formatter
			"isort", -- python formatter
			"black", -- python formatter
			"pylint",
			"eslint_d",
			"ast_grep",
			"java-debug-adapter",
			"java-test",
			"google-java-format",
			"golangci-lint",
			"markdownlint",
		}
		require("mason").setup({
			ui = {
				border = "rounded",
			},
		})

		require("mason-lspconfig").setup({
			automatic_enable = false,
		})
		require("mason-tool-installer").setup({
			ensure_installed = tools,
		})
	end,
}

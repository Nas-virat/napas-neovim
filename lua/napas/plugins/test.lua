return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"haydenmeade/neotest-jest",
		"fredrikaverpil/neotest-golang",
	},
	keys = {
		{
			"<leader>Tn",
			function()
				require("neotest").run.run()
			end,
			desc = "Test run nearest",
		},
		{
			"<leader>Tf",
			function()
				require("neotest").run.run(vim.fn.expand("%"))
			end,
			desc = "Test run current file",
		},
		{
			"<leader>Td",
			function()
				require("neotest").run.run({ strategy = "dap" })
			end,
			desc = "Debug  Test",
		},
		{
			"<leader>To",
			function()
				require("neotest").output.open()
			end,
			desc = "Test Output",
		},
		{
			"<leader>Ts",
			function()
				require("neotest").run.stop()
			end,
			desc = "Stop stop",
		},
		{
			"<leader>TS",
			function()
				require("neotest").summary.toggle()
			end,
			desc = "Test Summary",
		},
		{
			"<leader>Tw",
			function()
				require("neotest").watch.watch()
			end,
			desc = "Run Watch",
		},
	},
	config = function()
		-- get neotest namespace (api call creates or returns namespace)

		require("neotest").setup({
			-- your neotest config here
			adapters = {
				require("neotest-golang"),
				require("neotest-jest")({
					jestCommand = "npm test --",
					jestConfigFile = "custom.jest.config.ts",
					env = { CI = true },
					cwd = function(path)
						return vim.fn.getcwd()
					end,
				}),
			},
		})
	end,
}

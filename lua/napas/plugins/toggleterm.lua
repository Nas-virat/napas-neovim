return {
	-- amongst your other plugins
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		cmd = "ToggleTerm",
		config = true,
		keys = {
			{ "<C-t>", "<cmd>ToggleTerm<cr>", desc = "Toggle floating terminal" },
		},
		opts = {
			open_mapping = [[<C-t>]],
			direction = "float",
		},
	},
}

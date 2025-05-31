return {
	"akinsho/bufferline.nvim",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		require("bufferline").setup({
			options = {
				numbers = "none",
				close_command = "bdelete! %d",
				right_mouse_command = "bdelete! %d",
				left_mouse_command = "buffer %d",
				middle_mouse_command = nil,
				indicator = {
					icon = "▎",
					style = "icon",
				},
				buffer_close_icon = "x",
				modified_icon = "●",
				close_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
				max_name_length = 18,
				max_prefix_length = 15,
				tab_size = 18,
				diagnostics = false,
				diagnostics_update_in_insert = false,
				offsets = { { filetype = "NvimTree", text = "File Explorer", padding = 1 } },
				show_buffer_icons = true,
				show_buffer_close_icons = true,
				show_close_icon = true,
				show_tab_indicators = true,
				persist_buffer_sort = true,
				separator_style = "slant",
				enforce_regular_tabs = false,
				always_show_bufferline = true,
				sort_by = "id",
			},
		})
		-- Keybindings for Bufferline
		vim.api.nvim_set_keymap("n", "H", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "L", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })

		-- Keybinding to close the current buffer
		vim.keymap.set(
			"n",
			"<Leader>q",
			":bdelete<CR>",
			{ desc = "close current buffer", noremap = true, silent = true }
		)
	end,
}

local M = {
	"xiyaowong/transparent.nvim",
}

function M.config()
	require("transparent").setup({
		extra_groups = {
			"LspInlayHint",
		},
	})
end

return M

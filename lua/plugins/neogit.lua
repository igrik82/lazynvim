return {
	"neogitorg/neogit",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
	},
	keys = {

		{
			"<leader>go",
			":Neogit<CR>",
			desc = "Neogit",
		},
		{
			"<leader>gc",
			":Neogit commit<CR>",
			desc = "Neogit commit",
		},
		{
			"<leader>gs",
			":Neogit kind=vsplit<CR>",
			desc = "Neogit vertical split",
		},
	},
	config = function()
    require("neogit").setup({})
		local wk = require("which-key")
		local mappings = {
			g = "NeoGit",
		}
		local opts = { prefix = "<leader>" }
		wk.register(mappings, opts)
	end,
}

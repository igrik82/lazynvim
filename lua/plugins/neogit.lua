return {
	"neogitorg/neogit",
	branch = "master",
	-- (function()
	-- 	if vim.version.gt(vim.version(), { 0, 9, 99 }) then
	-- 		return "nightly"
	-- 	else
	-- 		return "master"
	-- 	end
	-- end)(),
	-- tag = "v0.0.1",
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
		wk.add({ "<leader>g", group = "Neogit" })
	end,
}

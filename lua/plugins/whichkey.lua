return {
	"folke/which-key.nvim",
	lazy = true,
	event = "VeryLazy",
	keys = { "<leader>", "<c-r>" },
	cmd = "WhichKey",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 400
	end,
	opts = {},
}

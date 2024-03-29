return {
	"numToStr/Comment.nvim",
	event = "VeryLazy",
	init = function()
		local wk = require("which-key")
		local mappings = {
			c = "Comments",
		}
		local opts = { prefix = "<leader>" }
		wk.register(mappings, opts)
	end,
	opts = {
		ignore = "^$",
		toggler = {
			line = "<leader>cc",
			block = "<leader>cb",
		},
		opleader = {
			line = "<leader>cc",
			block = "<leader>cb",
		},
	},
}

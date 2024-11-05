return {
	"nvim-treesitter/nvim-treesitter",
	-- event = "VeryLazy",
	event = { "BufReadPre", "BufNewFile" },
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		-- configure telescope
		treesitter.setup({
			ensure_installed = {
				"markdown",
				"markdown_inline",
				"python",
				"c",
				"cpp",
				"bash",
				"json",
				"dockerfile",
				"gitignore",
				"lua",
				"yaml",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
			indent = {
				enable = true,
			},
		})
	end,
}

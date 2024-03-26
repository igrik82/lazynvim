return {
	"nvim-treesitter/nvim-treesitter",
	event = "VeryLazy",
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		-- configure telescope
		treesitter.setup({
      ensure_installed = {
        "markdown",
        "markdown_inline",
      },
			auto_install = true,
			highlight = {
				enable = true,
			},
		})
	end,
}

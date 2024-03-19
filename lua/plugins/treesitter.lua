return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local treesitter = require("nvim-treesitter.configs")

		-- configure telescope
		treesitter.setup({
			ensure_installed = {
				"gitignore",
				"arduino",
				"cpp",
				"c",
				"python",
				"markdown",
				"markdown_inline",
				"vim",
				"vimdoc",
				"bash",
				"css",
				"dockerfile",
				"html",
				"json",
				"lua",
				"sql",
				"yaml",
				"diff",
				"git_rebase",
				"gitattributes",
				"passwd",
				"requirements",
				"toml",
			},
			auto_install = true,
			highlight = {
				enable = true,
			},
		})
	end,
}

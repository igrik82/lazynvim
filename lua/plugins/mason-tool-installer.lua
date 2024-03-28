return {
	"whoissethdaniel/mason-tool-installer.nvim",
	event = "VeryLazy",
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = {
				"cpptools",
			},
			auto_update = true,
			run_on_start = true,
		})
	end,
}

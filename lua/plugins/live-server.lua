return {
	"ngtuonghy/live-server-nvim",
	-- build = ":LiveServerInstall",
	cmd = { "LiveServerStart", "LiveServerStop" },
	keys = {
		{ "<leader>ss", ":LiveServerStart -f<cr>", desc = "Live Server Start" },
		{ "<leader>sS", ":LiveServerStop<cr>", desc = "Live Server Stop" },
	},
	init = function()
		require("live-server-nvim").setup({
			custom = {
				"--port=12345",
				"--no-css-inject",
			},
			serverPath = vim.fn.stdpath("data") .. "/live-server/", --default
			open = "folder", -- folder|cwd     --default
		})

		local wk = require("which-key")
		wk.add({ "<leader>s", group = "Live Server" })
	end,
}

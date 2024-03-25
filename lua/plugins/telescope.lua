return {
	"nvim-telescope/telescope.nvim", --, tag = '0.1.6',
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"BurntSushi/ripgrep",
		"nvim-telescope/telescope-fzy-native.nvim",
		build = "make",
		"sharkdp/fd",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "f", "", desc = "Telescope" },
		{
			"<leader>ff",
			":lua require('telescope.builtin').find_files()<cr>",
			desc = "Telescope find files",
		},
		{
			"<leader>fg",
			":lua require('telescope.builtin').live_grep()<cr>",
			desc = "Telescope live grep",
		},
		{
			"<leader>fb",
			":lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
			desc = "Telescope current buffer fuzzy find",
		},
		{
			"<leader>fh",
			":lua require('telescope.builtin').help_tags()<cr>",
			desc = "Telescope help tags",
		},
	},
	init = function()
		require("telescope").load_extension("fzy_native")

		local wk = require("which-key")
		local mappings = {
			f = {
				name = "Telescope",
			},
		}
		local opts = { prefix = "<leader>" }
		wk.register(mappings, opts)
	end,
}

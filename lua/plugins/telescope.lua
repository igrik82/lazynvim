---@diagnostic disable: unused-local
return {
	{
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
		init = function()
			require("telescope").load_extension("fzy_native")

			local wk = require("which-key")
			local mappings = {

				-- Mapping
				f = "Telescope",
				ff = { ":lua require('telescope.builtin').find_files()<cr>", "Find files in current directory" },
				fb = {
					":lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>",
					"Search for the string in current buffer",
				},
				fg = {
					":lua require('telescope.builtin').live_grep()<cr>",
					"Search for the string in current directory",
				},
			}
			local opts = { prefix = "<leader>" }
			wk.register(mappings, opts)
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({
							-- even more opts
						}),
					},
				},
			})
			-- To get ui-select loaded and working with telescope, you need to call
			-- load_extension, somewhere after setup function:
			require("telescope").load_extension("ui-select")
		end,
	},
}

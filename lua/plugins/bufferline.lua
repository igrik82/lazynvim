return {
	{
		"moll/vim-bbye",
		keys = {
			{ "<leader>x", ":Bdelete<CR>", desc = "Close current buffer" },
		},
	},
	{
		"akinsho/bufferline.nvim",
		keys = {
			{ "<tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
			{ "<S-tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
		},
		event = "BufLeave",
		version = "*",
		config = function()
			require("bufferline").setup({
				options = {
					buffer_close_icon = "",
					close_command = "Bdelete", -- can be a string | function, | false see "Mouse actions"
					mode = "buffers",
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							separator = true,
							padding = 1,
						},
					},
					tab_size = 28,
					diagnostics = "nvim_lsp",
					separator_style = "slant", --| "slope" | "thick" | "thin" | { 'any', 'any' },
					indicator = {
						-- icon = "  ", -- this should be omitted if indicator style is not 'icon'
						-- icon = "  ",
						-- icon = "  ",
						-- icon = "  ",
						-- icon = "  ",
						-- icon = "  ",
						-- icon = "  ",
						-- icon = "  ",
						-- icon = "  ",
						-- icon = " ● ",
						-- style = "icon",
						style = "none",
					},
				},
				highlights = {
					close_button = {
						fg = "#515257",
					},
					close_button_visible = {
						fg = "#eb1a07",
					},
					close_button_selected = {
						fg = "#eb1a07",
						--
						--   fg = "<colour-value-here>",
						--   bg = "<colour-value-here>",
					},
				},
			})
		end,
	},
}

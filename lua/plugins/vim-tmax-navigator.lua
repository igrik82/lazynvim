return {
	{
		"christoomey/vim-tmux-navigator",
		ft = { "cpp", "python" },
		keys = {
			{ "<C-Left>", ":TmuxNavigateLeft<cr>" },
			{ "<C-Down>", ":TmuxNavigateDown<cr>" },
			{ "<C-Up>", ":TmuxNavigateUp<cr>" },
			{ "<C-Right>", ":TmuxNavigateRight<cr>" },
			{ "<C-\\>", ":TmuxNavigatePrevious<cr>" },
		},
	},
	{
		"preservim/vimux",
		keys = {
			{
				"<leader>tr",
				":w<cr>:VimuxRunCommand('~/.bin/runner.sh ' . bufname('%') . ' ' . getcwd())<cr><cr>",
				desc = "Compile & run",
			},
			{
				"<leader>tR",
				":w<cr>:VimuxRunCommand('~/.bin/runner.sh ' . bufname('%') . ' ' . getcwd())<cr> :TmuxNavigateRight<cr>",
				desc = "Compile & run with focus",
			},
			{
				"<leader>to",
				":w<cr>:VimuxOpenRunner<cr>",
				desc = "Open terminal",
			},
			{
				"<leader>tc",
				":w<cr>:VimuxCloseRunner<cr>",
				desc = "Close terminal",
			},
			{
				"<leader>tz",
				":w<cr>:VimuxZoomRunner<cr>",
				desc = "Zoom terminal",
			},
			{
				"<leader>tl",
				":w<cr>:VimuxClearTerminalScreen<cr>",
				desc = "Clear terminal",
			},
		},
		init = function()
			vim.g.VimuxOrientation = "h"
			vim.g.VimuxHeight = "40"

			local wk = require("which-key")
			wk.add({ "<leader>t", group = "Terminal" })
		end,
	},
}

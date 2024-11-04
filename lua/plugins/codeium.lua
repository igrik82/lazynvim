return {
	"Exafunction/codeium.vim",
	event = "InsertEnter",
	-- after the commit :wq stop responding
	-- commit = "3cc779d",
	keys = {
		{ "<C-x>", ":CodeiumToggle<CR>", desc = "Codeium toggle" },
	},
	config = function()
		vim.keymap.set("i", "<C-a>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<C-c>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true })
		-- Disable TAB
		vim.g.codeium_no_map_tab = 1
	end,
}

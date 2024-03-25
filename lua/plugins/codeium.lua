return {
	"Exafunction/codeium.vim",
	event = "InsertEnter",
	config = function()
		vim.keymap.set("i", "<C-a>", function()
			return vim.fn["codeium#Accept"]()
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<C-c>", function()
			return vim.fn["codeium#CycleCompletions"](1)
		end, { expr = true, silent = true })
		vim.keymap.set("i", "<C-x>", function()
			return vim.fn["codeium#Clear"]()
		end, { expr = true, silent = true })
		-- Disable TAB
		vim.g.codeium_no_map_tab = 1
	end,
}

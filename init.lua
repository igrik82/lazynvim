--map leader
vim.g.mapleader = " "

--Settings
require("core.keymaps")
require("core.options")

--Setup lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins", {
	change_detection = {
		notify = false,
	},
	install = {
		colorscheme = { "gruvbox-material", "habamax" },
	},
	checker = {
		enabled = true,
		concurrency = 1,
		notify = false,
	},
})

local status, _ = pcall(vim.cmd, "colorscheme gruvbox-material")
if not status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end

--require("sonokai").setup()
require("lualine").setup({
	options = {
		theme = "gruvbox-material",
	},
})

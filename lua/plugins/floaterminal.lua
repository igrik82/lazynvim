return{
  "voldikss/vim-floaterm",
  config = function()
    vim.g.floaterm_gitcommit = "floaterm"
    vim.g.floaterm_autoinsert = 1
    vim.g.floaterm_width = 0.8
    vim.g.floaterm_height = 0.8
    vim.g.floaterm_wintitle = 0
    vim.g.floaterm_autoclose = 0
    vim.keymap.set("n", "<leader>t", ":w<CR>:belowright split |!bash ~/Projects/cpp/compile.sh %<CR>|:q |:FloatermNew ./main<CR>")
    vim.keymap.set("n", "<leader>r", ":w<CR>:FloatermNew --height=0.9 --width=0.9 --autoclose=0 python %<CR>")
  end
}


return {
  "folke/which-key.nvim",
  lazy = true,
  event = "VeryLazy",
  keys = {"<leader>", "<c-r>"},
  cmd = "WhichKey",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 400
 local wk = require("which-key") 
      local mappings = {

  -- Compile and run C|C++ program
	t = {":w<CR>:belowright split |!bash ~/Projects/cpp/compile.sh %<CR>|:q |:FloatermNew ./main<CR>", "Compile & run"},


}
local opts = {prefix = "<leader>", "<c-r>"}
wk.register(mappings, opts)
  end,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
}

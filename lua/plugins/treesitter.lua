return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    local treesitter = require("nvim-treesitter.configs")

    -- configure telescope
    treesitter.setup({
      auto_install = true,
      highlight = {
        enable = true,
      },
    })
  end,
}

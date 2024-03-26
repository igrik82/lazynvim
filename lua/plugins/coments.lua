return {
  "numToStr/Comment.nvim",
  event = "VeryLazy",
  init = function()
    local wk = require("which-key")
    local mappings = {
      g = "Comments",
    }
    local opts = { prefix = "<leader>" }
    wk.register(mappings, opts)
  end,
  opts = {
    ignore = "^$",
    toggler = {
      line = "<leader>gc",
      block = "<leader>gb",
    },
    opleader = {
      line = "<leader>gc",
      block = "<leader>gb",
    },
  },
}

return {
  "nvimdev/lspsaga.nvim",
  -- event = "VeryLazy",
  ft = { "lua", "python", "sh", "c", "cpp", "arduino", "html", "css" },
  config = function()
    require("lspsaga").setup({})
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons",   -- optional
  },
}

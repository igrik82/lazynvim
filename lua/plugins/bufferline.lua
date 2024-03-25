return {
  {
    "moll/vim-bbye",
    keys = {
      { "<leader>x", ":Bdelete<CR>", desc = "Close current buffer" },
    },
  },
  {
    "akinsho/bufferline.nvim",
    keys = {
      { "<tab>",   "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<S-tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    },
    version = "*",
    config = function()
      require("bufferline").setup({
        options = {
          buffer_close_icon = "",
          close_command = "Bdelete", -- can be a string | function, | false see "Mouse actions"
          mode = "buffers",
          offsets = {
            {
              filetype = "neo-tree",
              text = "File Explorer",
              separator = true,
              padding = 1,
            },
          },
          diagnostics = "nvim_lsp",
          indicator = {
            -- icon = "  ", -- this should be omitted if indicator style is not 'icon'
            -- icon = "  ",
            -- icon = "  ",
            -- icon = "  ",
            -- icon = "  ",
            -- icon = "  ",
            icon = "  ",
            -- icon = "  ",
            -- icon = "  ",
            -- icon = " ● ",
            style = "icon",
          },
        },
      })
    end,
  },
}

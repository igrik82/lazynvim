return {
  {
    "moll/vim-bbye",
    config = function()
      vim.keymap.set("n", "<leader>x", ":Bdelete<CR>", { desc = "Close current buffer" })
    end,
  },
  {
    "akinsho/bufferline.nvim",
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

      -- keymaps for bufferline
      vim.keymap.set("n", "<tab>", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
      vim.keymap.set("n", "<S-tab>", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
    end,
  },
}

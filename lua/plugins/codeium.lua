return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function()
    vim.keymap.set("i", "<C-a>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true })
    vim.keymap.set("i", "<C-c>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true, silent = true })
  end,
}
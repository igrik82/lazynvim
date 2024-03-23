return {
  "sainnhe/gruvbox-material",
  config = function()
    -- Accent themes by default medium
    -- vim.g.gruvbox_material_background = "soft"
    -- vim.g.gruvbox_material_background = "hard"

    vim.g.gruvbox_material_better_performance = 1

    vim.cmd.colorscheme("gruvbox-material")
  end,
}

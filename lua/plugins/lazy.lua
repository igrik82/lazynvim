return{
  "folke/lazy.nvim",
  config = function()
checker = {
    -- automatically check for plugin updates
    enabled = true,
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
  }
  end
}

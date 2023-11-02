local M = {
  "anuvyklack/hydra.nvim",
  event = "VeryLazy",
  dependencies = {
    "anuvyklack/keymap-layer.nvim",
  },
  config = function()
    require("core.plugins.hydra.hydra")
  end,
}

return M

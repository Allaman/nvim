local M = {
  "goolord/alpha-nvim",
  dependencies = {
    "kyazdani42/nvim-web-devicons",
  },
  config = function()
    require("core.plugins.alpha.alpha")
  end,
}

return M

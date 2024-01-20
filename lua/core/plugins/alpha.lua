local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "famiu/bufdelete.nvim", -- for autocmd
  },
  config = function()
    require("core.plugins.alpha.alpha")
  end,
}

return M

local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "famiu/bufdelete.nvim", -- for autocmd
    {
      "echasnovski/mini.visits", -- oldfiles alternative
      enabled = vim.g.config.plugins.alpha.use_mini_visits,
      config = true,
    },
  },
  config = function()
    require("core.plugins.alpha.alpha")
  end,
}

return M

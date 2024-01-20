local config = vim.g.config.plugins.trouble

return {
  "folke/trouble.nvim",
  lazy = true,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = config.enable,
  opts = config.opts,
}

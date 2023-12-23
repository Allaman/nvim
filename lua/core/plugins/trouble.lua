local config = vim.g.config.plugins.trouble

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  enabled = config.enable,
  opts = config.opts,
}

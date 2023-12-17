return {
  "stevearc/oil.nvim",
  enabled = vim.g.config.plugins.oil.enable,
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = {
    vim.g.config.plugins.oil.key_mappings(),
  },
}

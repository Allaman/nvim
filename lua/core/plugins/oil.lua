return {
  "stevearc/oil.nvim",
  enabled = vim.g.config.plugins.oil.enable,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    vim.g.config.plugins.oil.key_mappings(),
  },
}

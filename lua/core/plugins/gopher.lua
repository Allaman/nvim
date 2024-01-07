return {
  "olexsmir/gopher.nvim",
  enabled = vim.g.config.plugins.gopher.enable,
  ft = "go",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
}

return {
  "stevearc/overseer.nvim",
  enabled = vim.g.config.plugins.overseer.enable,
  opts = {},
  config = function()
    require("overseer").setup()
    vim.g.config.plugins.overseer.key_mappings()
  end,
}

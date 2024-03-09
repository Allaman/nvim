local config = vim.g.config.plugins.conform

return {
  "stevearc/conform.nvim",
  event = config.event,
  enabled = config.enable,
  opts = config.opts,
  config = function(_, opts)
    config.config_function(opts)
  end,
}

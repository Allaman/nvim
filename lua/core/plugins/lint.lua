local config = vim.g.config.plugins.nvim_lint

return {
  "mfussenegger/nvim-lint",
  event = config.opts.events,
  enabled = config.enable,
  opts = config.opts,
  config = function(_, opts)
    config.config_function(opts)
  end,
}

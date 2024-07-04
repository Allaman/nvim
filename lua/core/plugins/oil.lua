local conf = vim.g.config.plugins.oil

return {
  "stevearc/oil.nvim",
  enabled = conf.enable,
  opts = conf.opts,
  config = function(_, opts)
    conf.key_mappings()
  end,
}

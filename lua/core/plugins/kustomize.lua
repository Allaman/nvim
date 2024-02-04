local conf = vim.g.config.plugins.kustomize
return {
  "allaman/kustomize.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  ft = "yaml",
  opts = conf.opts,
  dev = conf.dev,
}

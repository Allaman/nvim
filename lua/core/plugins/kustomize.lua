local conf = vim.g.config.plugins.kustomize
return {
  "allaman/kustomize.nvim",
  dependencies = "nvim-lua/plenary.nvim",
  ft = "yaml",
  config = true,
  opts = conf.opts,
  dev = conf.dev,
}

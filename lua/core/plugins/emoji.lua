local config = vim.g.config.plugins.emoji
return {
  "allaman/emoji.nvim",
  ft = "markdown",
  dependencies = "hrsh7th/nvim-cmp",
  opts = {
    enable_cmp_integration = config.enable_cmp_integration,
    plugin_path = config.plugin_path,
  },
  dev = true,
}

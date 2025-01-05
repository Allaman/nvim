local user_config = vim.g.config.plugins.markdown or {}

local default_config = {
  enabled = false,
  opts = {},
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "MeanderingProgrammer/markdown.nvim",
  enabled = config.enabled,
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = "markdown",
  opts = config.opts,
}

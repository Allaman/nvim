local user_config = vim.g.config.plugins.grug_far or {}

local default_config = {
  enabled = false,
  opts = {},
  keys = {},
  cmd = "GrugFar",
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  enabled = config.enabled,
  "MagicDuck/grug-far.nvim",
  cmd = config.cmd,
  opts = config.opts,
  keys = config.keys,
}

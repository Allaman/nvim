local user_config = vim.g.config.plugins.fugitive or {}

local default_config = {
  enabled = true,
  keys = {},
  opts = {},
}

local config = vim.tbl_deep_extend("force", default_config, (user_config or {}))

return {
  "tpope/vim-fugitive",
  enabled = config.enabled,
  keys = config.keys,
  cmd = "G",
}

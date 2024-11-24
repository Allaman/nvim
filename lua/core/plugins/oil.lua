local user_config = vim.g.config.plugins.oil or {}

local default_config = {
  enabled = false,
  opts = {
    default_file_explorer = true,
    delete_to_trash = true,
    skip_confirm_for_simple_edits = true,
  },
  keys = {
    { "-", "<cmd>Oil<cr>", desc = "Open Oil" },
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "stevearc/oil.nvim",
  enabled = config.enabled,
  keys = config.keys,
  config = true,
}

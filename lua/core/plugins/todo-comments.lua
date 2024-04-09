local user_config = vim.g.config.plugins.todo_comments or {}

local default_config = {
  enabled = false,
  event = { "BufReadPre", "BufNewFile", "VimEnter" },
  opts = {},
  keys = {},
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope", "TodoLocList", "TodoQuickFix" },
    event = config.event,
    enabled = config.enabled,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = config.opts,
    keys = config.keys,
  },
}

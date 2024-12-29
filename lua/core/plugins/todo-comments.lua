local user_config = vim.g.config.plugins.todo_comments or {}

local default_config = {
  enabled = false,
  event = { "VeryLazy" },
  opts = {},
  keys = {
    {
      "<leader>qT",
      "<cmd>TodoTrouble<cr>",
      desc = "TODO",
    },
    {
      "<leader>qt",
      function()
        require("todo-comments.fzf").todo()
      end,
      desc = "TODO FZF",
    },
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  {
    "folke/todo-comments.nvim",
    event = config.event,
    enabled = config.enabled,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = config.opts,
    keys = config.keys,
  },
}

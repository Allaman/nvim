local user_config = vim.g.config.plugins.trouble or {}

local default_config = {
  enabled = false,
  opts = {
    auto_preview = false,
    modes = {
      preview_diagnostics = {
        mode = "diagnostics",
        preview = {
          type = "split",
          relative = "win",
          position = "right",
          size = 0.3,
        },
      },
    },
  },
  keys = {
    { "<leader>x", "", desc = "Trouble" },
    {
      "<leader>qq",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Toggle",
    },
    {
      "<leader>xl",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>qj",
      function()
        require("trouble").next({ skip_groups = true, jump = true })
      end,
      desc = "Next",
    },
    {
      "<leader>qk",
      function()
        require("trouble").prev({ skip_groups = true, jump = true })
      end,
      desc = "Prev",
    },
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  {
    "folke/trouble.nvim",
    enabled = config.enabled,
    opts = config.opts,
    keys = config.keys,
  },
}

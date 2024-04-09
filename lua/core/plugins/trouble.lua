local user_config = vim.g.config.plugins.trouble or {}

local default_config = {
  enabled = false,
  opts = {
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
  groups = {
    ["<leader>x"] = { name = "Trouble" },
  },
  keys = {
    {
      "<leader>xx",
      "<cmd>Trouble preview_diagnostics toggle<cr>",
      desc = "Diagnostics (Trouble)",
    },
    {
      "<leader>xX",
      "<cmd>Trouble preview_diagnostics toggle filter.buf=0<cr>",
      desc = "Buffer Diagnostics (Trouble)",
    },
    {
      "<leader>xd",
      "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      desc = "LSP Definitions/References",
    },
    {
      "<leader>xs",
      "<cmd>Trouble symbols toggle focus=false<cr>",
      desc = "Symbols (Trouble)",
    },
    {
      "<leader>xl",
      "<cmd>Trouble loclist toggle<cr>",
      desc = "Location List (Trouble)",
    },
    {
      "<leader>xq",
      "<cmd>Trouble qflist toggle<cr>",
      desc = "Quickfix List (Trouble)",
    },
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  {
    "folke/trouble.nvim",
    branch = "dev",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    enabled = config.enabled,
    opts = config.opts,
    keys = config.keys,
  },
  -- which key integration
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      groups = config.groups,
    },
  },
}

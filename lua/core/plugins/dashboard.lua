return {
  "nvimdev/dashboard-nvim",
  enabled = function()
    local utils = require("utils.functions")
    local db = utils.safe_nested_config(vim.g.config, "dashboard")
    if db == "dashboard" then
      return true
    end
    return false -- not default dashboard
  end,
  event = "VimEnter",
  dependencies = {
    "famiu/bufdelete.nvim", -- for autocmd
  },
  opts = {
    config = {
      header = {
        [[                                             ]],
        [[  _______             ____   ___.__          ]],
        [[  \      \   ____  ___\   \ /   |__| _____   ]],
        [[  /   |   \_/ __ \/  _ \   Y   /|  |/     \  ]],
        [[ /    |    \  ___(  <_> \     / |  |  Y Y  \ ]],
        [[ \____|__  /\___  \____/ \___/  |__|__|_|  / ]],
        [[         \/     \/                       \/  ]],
        [[                                             ]],
      },
      shortcut = {
        {
          icon = " ",
          desc = "New",
          action = "ene | startinsert",
          key = "e",
        },
        {
          icon = "󰍉 ",
          desc = "Find",
          action = require("utils.functions").project_files(),
          key = "f",
        },
        {
          icon = " ",
          desc = "Grep",
          action = "Telescope live_grep",
          key = "s",
        },
        {
          icon = " ",
          desc = "Browse",
          action = require("utils.functions").file_browser(),
          key = "b",
        },
        {
          icon = " ",
          desc = "Git",
          action = "Neogit",
          key = "g",
        },
        { icon = " ", desc = "Lazy", group = "Label", action = "Lazy check", key = "l" },
        { desc = "Quit", group = "Number", action = "q", key = "q" },
      },
      mru = { limit = 10, icon = " ", label = "Recent files", cwd_only = true },
      project = {
        enable = true,
        limit = 5,
        icon = "󰹈 ",
        label = "Recent Projects",
        action = "Telescope find_files cwd=",
      },
      footer = { "Nam et ipsa scientia potestas est" },
    },
  },
  config = function(_, opts)
    require("utils.functions").dashboard_autocmd(":Dashboard")
    require("dashboard").setup(opts)
  end,
}

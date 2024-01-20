local M = {
  "anuvyklack/hydra.nvim",
  lazy = true,
  dependencies = {
    "anuvyklack/keymap-layer.nvim",
    {
      -- for maximize mapping
      "anuvyklack/windows.nvim",
      lazy = true,
      dependencies = {
        "anuvyklack/middleclass",
        "anuvyklack/animation.nvim",
      },
      opts = {
        autowidth = { -- |windows.autowidth|
          enable = false,
          winwidth = 5, -- |windows.winwidth|
          filetype = { -- |windows.autowidth.filetype|
            help = 2,
          },
        },
        ignore = { -- |windows.ignore|
          buftype = { "quickfix" },
          filetype = { "NvimTree", "neo-tree", "undotree", "NeogitStatus" },
        },
        animation = {
          enable = false,
          duration = 300,
          fps = 30,
          easing = "in_out_sine",
        },
      },
    },
  },
  config = function()
    require("core.plugins.hydra.hydra")
  end,
}

return M

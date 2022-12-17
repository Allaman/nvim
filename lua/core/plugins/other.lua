local utils = require("core.utils")
local settings = require("core.settings")
local M = {}

M.packages = {
  {
    "anuvyklack/hydra.nvim",
    requires = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
    commit = "ea91aa820a6cecc57bde764bb23612fff26a15de",
    config = utils.get_config("hydra"),
  },
  {
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup()
    end,
  },
  { "vimpostor/vim-tpipeline", disable = settings.disable_tmux_statusline_integration },
  {
    "max397574/colortils.nvim",
    cmd = "Colortils",
    config = function()
      require("colortils").setup()
    end,
  },
  -- NOTE: use https://github.com/Akianonymus/nvim-colorizer.lua ?
  -- NOTE: use https://github.com/NvChad/nvim-colorizer.lua ?
  {
    "norcalli/nvim-colorizer.lua",
    ft = { "scss", "css", "html" },
    config = function()
      require("colorizer").setup()
    end,
    disable = settings.disable_colorizer,
  },
  { "tweekmonster/startuptime.vim" },
  {
    "ziontee113/icon-picker.nvim",
    requires = "stevearc/dressing.nvim",
    config = function()
      require("icon-picker").setup({
        disable_legacy_commands = true,
      })
    end,
  },
}

return M

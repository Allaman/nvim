local themes = {
  nightfox = {
    "EdenEast/nightfox.nvim",
    config = function()
      require("core.plugins.themes.nightfox")
    end,
  },
  tundra = {
    "sam4llis/nvim-tundra",
    config = function()
      require("core.plugins.themes.tundra")
    end,
  },
  tokyonight = {
    "folke/tokyonight.nvim",
    branch = "main",
    config = function()
      require("core.plugins.themes.tokyonight")
    end,
  },
  kanagawa = {
    "rebelot/kanagawa.nvim",
    config = function()
      require("lua.core.plugins.themes.kanagawa")
    end,
  },
  oxocarbon = {
    "nyoom-engineering/oxocarbon.nvim",
    config = function()
      vim.opt.background = "dark" -- set this to dark or light
      vim.cmd("colorscheme oxocarbon")
    end,
  },
  catppuccin = {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("core.plugins.themes.catppuccin")
    end,
  },
}

local selectedTheme = themes[vim.g.config.theme.name]

return selectedTheme

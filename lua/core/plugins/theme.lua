local settings = require("core.settings")

if settings.theme == "nightfox" then
  return {
    "EdenEast/nightfox.nvim",
    config = function()
      require("core.plugins.themes.nightfox")
    end,
  }
elseif settings.theme == "tundra" then
  return {
    "sam4llis/nvim-tundra",
    config = function()
      require("core.plugins.themes.tundra")
    end,
  }
elseif settings.theme == "tokyonight" then
  return {
    "folke/tokyonight.nvim",
    branch = "main",
    config = function()
      require("core.plugins.themes.tokyonight")
    end,
  }
elseif settings.theme == "kanagawa" then
  return {
    "rebelot/kanagawa.nvim",
    config = function()
      require("lua.core.plugins.themes.kanagawa")
    end,
  }
elseif settings.theme == "oxocarbon" then
  return {
    "nyoom-engineering/oxocarbon.nvim",
    config = function()
      vim.opt.background = "dark" -- set this to dark or light
      vim.cmd("colorscheme oxocarbon")
    end,
  }
else
  return {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("core.plugins.themes.catppuccin")
    end,
  }
end

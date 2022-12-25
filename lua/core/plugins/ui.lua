local utils = require("core.utils")
local settings = require("core.settings")
local M = {}

local function get_theme()
  if settings.theme == "nightfox" then
    return { "EdenEast/nightfox.nvim", config = utils.get_config("ui.themes.nightfox") }
  elseif settings.theme == "tundra" then
    return { "sam4llis/nvim-tundra", config = utils.get_config("ui.themes.tundra") }
  elseif settings.theme == "tokyonight" then
    return { "folke/tokyonight.nvim", branch = "main", config = utils.get_config("ui.themes.tokyonight") }
  else
    return { "catppuccin/nvim", as = "catppuccin", config = utils.get_config("ui.themes.catppuccin") }
  end
end

M.packages = {
  get_theme(),
  {
    "nvim-telescope/telescope.nvim",
    requires = { "nvim-lua/popup.nvim", "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    module = "telescope",
    config = utils.get_config("ui.telescope"),
  },
  { "jvgrootveld/telescope-zoxide" },
  { "crispgm/telescope-heading.nvim" },
  { "nvim-telescope/telescope-symbols.nvim" },
  { "nvim-telescope/telescope-file-browser.nvim" },
  { "nvim-telescope/telescope-packer.nvim" },
  { "nvim-telescope/telescope-ui-select.nvim" },
  { "ptethng/telescope-makefile" },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    cmd = "NeoTree*",
    requires = {
      {
        "s1n7ax/nvim-window-picker", -- only needed if you want to use the commands with "_with_window_picker" suffix
        config = utils.get_config("ui.nvim-window-picker"),
      },
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = utils.get_config("ui.neotree"),
  },
  { "numToStr/Navigator.nvim", config = utils.get_config("ui.navigator") },
  {
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    config = utils.get_config("ui.symbols"),
  },
  {
    "akinsho/nvim-toggleterm.lua",
    config = utils.get_config("ui.toggleterm"),
  },
  { "ahmedkhalf/project.nvim", config = utils.get_config("ui.project") },
  { "folke/which-key.nvim", config = utils.get_config("ui.which-key") },
  {
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = utils.get_config("ui.alpha"),
  },
  {
    "anuvyklack/windows.nvim",
    event = "VimEnter",
    requires = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = utils.get_config("ui.windows"),
  },
  {
    "folke/noice.nvim",
    event = "VimEnter",
    config = utils.get_config("ui.noice"),
    requires = {
      "MunifTanjim/nui.nvim",
      { "rcarriga/nvim-notify", config = utils.get_config("ui.notify") },
    },
    disable = settings.disable_noice,
  },
  {
    "nvim-zh/colorful-winsep.nvim",
    config = function()
      require("colorful-winsep").setup({})
    end,
  },
}

return M

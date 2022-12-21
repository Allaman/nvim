local utils = require("core.utils")
local M = {}

M.packages = {
  {
    "allaman/kustomize.nvim",
    -- "~/workspace/github.com/allaman/kustomize.nvim",
    ft = "yaml",
    config = "require('kustomize').setup({defaults = true})",
  },
  {
    "~/live-server.nvim",
  },
  { "windwp/nvim-autopairs", config = utils.get_config("coding.nvim-autopairs") },
  {
    "nvim-treesitter/nvim-treesitter",
    config = utils.get_config("coding.treesitter"),
    run = ":TSUpdate",
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
  { "RRethy/nvim-treesitter-endwise", after = "nvim-treesitter" },
  {
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-calc",
      "lukas-reineke/cmp-rg",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = utils.get_config("coding.cmp"),
  },
  { "rafamadriz/friendly-snippets" },
  {
    "L3MON4D3/LuaSnip",
    requires = "saadparwaiz1/cmp_luasnip",
    config = utils.get_config("coding.luasnip"),
  },
  { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
  {
    "kevinhwang91/nvim-bqf",
    requires = {
      "junegunn/fzf",
      module = "nvim-bqf",
    },
    ft = "qf",
    config = utils.get_config("coding.nvim-bqf"),
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = utils.get_config("coding.indent-blankline"),
  },
  -- TODO: switch to https://github.com/B4mbus/todo-comments.nvim ?
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = utils.get_config("coding.todo"),
  },
  { "rhysd/vim-grammarous", ft = { "markdown", "latex" }, config = utils.get_config("coding.grammarous") },
  { "ray-x/go.nvim", requires = "ray-x/guihua.lua", config = utils.get_config("coding.go"), ft = { "go" } },
  { "LudoPinelli/comment-box.nvim", cmd = "CB*", config = utils.get_config("coding.comment-box") },
  { "echasnovski/mini.nvim", branch = "main", config = utils.get_config("coding.mini") },
  { "mfussenegger/nvim-ts-hint-textobject" },
  {
    "https://gitlab.com/yorickpeterse/nvim-pqf.git",
    config = function()
      require("pqf").setup()
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    -- TODO: alternative: https://github.com/Wansmer/treesj
    "aarondiel/spread.nvim",
    after = "nvim-treesitter",
    config = utils.get_config("coding.spread"),
  },
  {
    "ironhouzi/starlite-nvim",
    config = utils.get_config("coding.starlite-nvim"),
  },
  { "axieax/urlview.nvim", cmd = "Urlview", config = utils.get_config("ui.urlview") },
  { "famiu/bufdelete.nvim" },
  { "rafcamlet/nvim-luapad", ft = "lua" },
}

return M

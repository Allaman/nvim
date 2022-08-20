local settings = require("user-conf")
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
  return string.format('require("config/%s")', name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer...")
  vim.api.nvim_command("packadd packer.nvim")
end

-- initialize and configure packer
local packer = require("packer")

packer.init({
  enable = true, -- enable profiling via :PackerCompile profile=true
  threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  max_jobs = 20, -- Limit the number of simultaneous jobs. nil means no limit. Set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
  -- Have packer use a popup window
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

packer.startup(function(use)
  -- actual plugins list
  use("wbthomason/packer.nvim")

  use({
    "nvim-telescope/telescope.nvim",
    requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    config = get_config("telescope"),
  })

  use({ "jvgrootveld/telescope-zoxide" })
  use({ "crispgm/telescope-heading.nvim" })
  use({ "nvim-telescope/telescope-symbols.nvim" })
  use({ "nvim-telescope/telescope-file-browser.nvim" })
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
  use({ "nvim-telescope/telescope-packer.nvim" })
  use({ "nvim-telescope/telescope-ui-select.nvim" })

  use({ "kyazdani42/nvim-tree.lua", config = get_config("nvim-tree") })

  use({ "numToStr/Navigator.nvim", config = get_config("navigator") })

  use({ "windwp/nvim-autopairs", config = get_config("nvim-autopairs") })

  use({
    "nvim-treesitter/nvim-treesitter",
    config = get_config("treesitter"),
    run = ":TSUpdate",
  })

  use("nvim-treesitter/nvim-treesitter-textobjects")

  use("RRethy/nvim-treesitter-endwise")

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "f3fora/cmp-spell",
      "hrsh7th/cmp-calc",
      "lukas-reineke/cmp-rg",
      "hrsh7th/cmp-nvim-lsp-signature-help",
    },
    config = get_config("cmp"),
  })

  use({ "rafamadriz/friendly-snippets" })
  use({
    "L3MON4D3/LuaSnip",
    requires = "saadparwaiz1/cmp_luasnip",
    config = get_config("luasnip"),
  })

  -- requirement for Neogit
  use({
    "sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    config = get_config("diffview"),
  })

  use({
    "TimUntersberger/neogit",
    requires = { "nvim-lua/plenary.nvim" },
    cmd = "Neogit",
    config = get_config("neogit"),
  })

  use({ "f-person/git-blame.nvim", config = get_config("git-blame") })

  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = get_config("gitsigns"),
  })

  use({ "tpope/vim-fugitive" }) -- yeah this is not lua but one of the best Vim plugins ever

  use("p00f/nvim-ts-rainbow")

  use({
    "kevinhwang91/nvim-bqf",
    requires = { { "junegunn/fzf", module = "nvim-bqf" }, config = get_config("nvim-bqf") },
  })

  use("famiu/bufdelete.nvim")

  use({ "neovim/nvim-lspconfig", config = get_config("lsp") })

  use({ "onsails/lspkind-nvim", requires = { "famiu/bufdelete.nvim" } })

  use({
    "jose-elias-alvarez/null-ls.nvim",
    requires = { { "nvim-lua/plenary.nvim" } },
    config = get_config("null-ls"),
  })

  use({
    "simrat39/symbols-outline.nvim",
    cmd = { "SymbolsOutline" },
    config = get_config("symbols"),
  })

  use({
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = [[require("config/indent-blankline")]],
  })

  use({
    "akinsho/nvim-toggleterm.lua",
    keys = { "<C-n>", "<leader>fl" },
    config = get_config("toggleterm"),
  })

  use({
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = get_config("todo"),
  })

  use({ "ahmedkhalf/project.nvim", config = get_config("project") })

  use("ironhouzi/starlite-nvim")

  use({ "folke/which-key.nvim", config = get_config("which-key") })

  use("junegunn/vim-easy-align") -- no lua alternative, https://github.com/Vonr/align.nvim not working for me

  use({ "rhysd/vim-grammarous", cmd = "GrammarousCheck" })

  use({ "RRethy/vim-illuminate", config = get_config("illuminate") })

  use({
    "ptzz/lf.vim",
    requires = "voldikss/vim-floaterm",
    config = get_config("lf"),
  })

  if settings.theme == "nightfox" then
    use({ "EdenEast/nightfox.nvim", config = get_config("nightfox") })
  elseif settings.theme == "catppuccino" then
    use({ "catppuccin/nvim", as = "catppuccin", config = get_config("catppuccin") })
  else
    use({ "catppuccin/nvim", as = "catppuccin", config = get_config("catppuccin") })
  end

  use({ "tweekmonster/startuptime.vim" })

  use({ "ggandor/lightspeed.nvim" })

  use({ "ray-x/go.nvim", requires = "ray-x/guihua.lua", config = get_config("go"), ft = { "go" } })

  use({ "LudoPinelli/comment-box.nvim", config = get_config("comment-box") })

  use({ "rcarriga/nvim-notify", config = get_config("notify") })

  use({ "echasnovski/mini.nvim", branch = "stable", config = get_config("mini") })

  use({
    "https://gitlab.com/yorickpeterse/nvim-window.git",
    config = get_config("nvim-window"),
  })

  use({
    "waylonwalker/Telegraph.nvim",
    config = function()
      require("telegraph").setup({})
    end,
  })

  use({ "rhysd/conflict-marker.vim" })

  use({ "edluffy/specs.nvim", config = get_config("specs") })

  use({ "mfussenegger/nvim-ts-hint-textobject" })

  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = get_config("alpha-nvim"),
  })

  use({ "SmiteshP/nvim-navic" })

  use({
    "j-hui/fidget.nvim",
    config = function()
      require("fidget").setup({})
    end,
  })

  use({
    "kevinhwang91/nvim-ufo",
    requires = "kevinhwang91/promise-async",
    config = function()
      require("ufo").setup()
    end,
  })

  use({
    "https://gitlab.com/yorickpeterse/nvim-pqf.git",
    config = function()
      require("pqf").setup()
    end,
  })

  use({ "Djancyp/cheat-sheet" })

  use({ "vimpostor/vim-tpipeline" })

  use({
    "anuvyklack/hydra.nvim",
    requires = "anuvyklack/keymap-layer.nvim", -- needed only for pink hydras
    config = get_config("hydra"),
  })

  use({
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  })

  use({
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup()
    end,
  })
end)

-- TODO: ????
-- use {"lukas-reineke/headlines.nvim", config = get_config("headlines")}
-- https://github.com/glepnir/lspsaga.nvim
-- use 'glepnir/lspsaga.nvim'

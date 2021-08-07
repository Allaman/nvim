local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path}) execute 'packadd packer.nvim'
end

require('user')

return require('packer').startup(function()
  -- Packer can manage itself https://github.com/wbthomason/packer.nvim
  use 'wbthomason/packer.nvim'

  -- https://github.com/nvim-telescope/telescope.nvim
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }

  -- https://github.com/famiu/nvim-reload
  use 'famiu/nvim-reload'

  -- https://github.com/marko-cerovac/material.nvim
  -- use {
  --   'marko-cerovac/material.nvim',
  --   disable = O.theme.material.active,
  -- }

  -- https://github.com/folke/tokyonight.nvim
  use {
    'folke/tokyonight.nvim'
  }

  -- https://github.com/b3nj5m1n/kommentary
  use 'b3nj5m1n/kommentary'

  -- https://github.com/kyazdani42/nvim-tree.lua
  use 'kyazdani42/nvim-tree.lua'

  -- https://github.com/numToStr/Navigator.nvim
  use 'numToStr/Navigator.nvim'

  -- https://github.com/kyazdani42/nvim-web-devicons
  use 'kyazdani42/nvim-web-devicons'

  -- https://github.com/lewis6991/gitsigns.nvim
  use {
    'lewis6991/gitsigns.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }

  -- https://github.com/glepnir/galaxyline.nvim
  use {
    'glepnir/galaxyline.nvim',
      branch = 'main'
  }

  -- https://github.com/norcalli/nvim-colorizer.lua
  use 'norcalli/nvim-colorizer.lua'

  -- https://github.com/windwp/nvim-autopairs
  use 'windwp/nvim-autopairs'

  -- https://github.com/nvim-treesitter/nvim-treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  use 'nvim-treesitter/nvim-treesitter-textobjects'

  -- https://github.com/tjdevries/astronauta.nvim
  use 'tjdevries/astronauta.nvim'

  -- https://github.com/hrsh7th/nvim-compe
  use 'hrsh7th/nvim-compe'

  -- https://github.com/hrsh7th/vim-vsnip
  use 'hrsh7th/vim-vsnip'
  -- https://github.com/rafamadriz/friendly-snippets
  use 'rafamadriz/friendly-snippets'

  -- https://github.com/sbdchd/neoformat
  use 'sbdchd/neoformat'

  -- https://github.com/phaazon/hop.nvim
  use {
  'phaazon/hop.nvim',
  as = 'hop',
  config = function()
    require'hop'.setup {
        keys = 'etovxqpdygfblzhckisuran'
      }
  end
  }

  -- https://github.com/sindrets/diffview.nvim
  -- https://github.com/TimUntersberger/neogit
  use {
    'TimUntersberger/neogit',
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    }
  }

  -- https://github.com/p00f/nvim-ts-rainbow
  use 'p00f/nvim-ts-rainbow'

  -- https://github.com/kevinhwang91/nvim-bqf
  use 'kevinhwang91/nvim-bqf'
  -- only used for bqf filter view
  use 'junegunn/fzf'

  -- https://github.com/akinsho/nvim-bufferline.lua
  use {
    'akinsho/nvim-bufferline.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }

  -- https://github.com/famiu/bufdelete.nvim
  use 'famiu/bufdelete.nvim'

  -- https://github.com/neovim/nvim-lspconfig
  use 'neovim/nvim-lspconfig'

  -- https://github.com/simrat39/symbols-outline.nvim
  use 'simrat39/symbols-outline.nvim'

  -- https://github.com/lukas-reineke/indent-blankline.nvim
  use {
    "lukas-reineke/indent-blankline.nvim",
    branch = lua,
    setup = function()
      vim.g.indent_blankline_char = "│"
      vim.g.indent_blankline_show_first_indent_level = true
      vim.g.indent_blankline_filetype_exclude = {
        "startify",
        "dashboard",
        "dotooagenda",
        "log",
        "fugitive",
        "gitcommit",
        "packer",
        "vimwiki",
        "markdown",
        "json",
        "txt",
        "vista",
        "help",
        "todoist",
        "NvimTree",
        "peekaboo",
        "git",
        "TelescopePrompt",
        "undotree",
        "flutterToolsOutline",
        "" -- for all buffers without a file type
      }
      vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
      vim.g.indent_blankline_show_trailing_blankline_indent = false
      vim.g.indent_blankline_show_current_context = true
      vim.g.indent_blankline_char_list = {'|', '¦', '┆', '┊'}
      vim.g.indent_blankline_space_char = ' '
      vim.g.indent_blankline_context_patterns = {
        "class",
        "function",
        "method",
        "block",
        "list_literal",
        "selector",
        "^if",
        "^table",
        "if_statement",
        "while",
        "for"
      }
    end
  }

  -- https://github.com/ray-x/lsp_signature.nvim
  use 'ray-x/lsp_signature.nvim'

  -- https://github.com/akinsho/nvim-toggleterm.lua
  use 'akinsho/nvim-toggleterm.lua'

  -- https://github.com/blackCauldron7/surround.nvim
  use {
  "blackCauldron7/surround.nvim",
  config = function()
    vim.g.surround_mappings_style = "surround"
    require'surround'.setup {}
  end
  }

  use 'sotte/presenting.vim'


  -- brauch ich????
  -- https://github.com/glepnir/lspsaga.nvim
  -- use 'glepnir/lspsaga.nvim'
end)


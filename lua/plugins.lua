local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_config(name)
    return string.format("require(\"config/%s\")", name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git", "clone", "https://github.com/wbthomason/packer.nvim",
        install_path
    })
    execute "packadd packer.nvim"
end

-- initialize and configure packer
local packer = require("packer")
packer.init {
    enable = true, -- enable profiling via :PackerCompile profile=true
    threshold = 0 -- the amount in ms that a plugins load time must be over for it to be included in the profile
}
local use = packer.use
packer.reset()

-- actual plugins list
use "wbthomason/packer.nvim"

use {
    "nvim-telescope/telescope.nvim",
    requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
    config = get_config("telescope")
}

use {"jvgrootveld/telescope-zoxide"}
use {"crispgm/telescope-heading.nvim"}
use {"nvim-telescope/telescope-symbols.nvim"}
use {"nvim-telescope/telescope-file-browser.nvim"}

use {"kyazdani42/nvim-tree.lua", config = get_config("nvim-tree")}

use {"numToStr/Navigator.nvim", config = get_config("navigator")}

use {
    "nvim-lualine/lualine.nvim",
    config = get_config("lualine"),
    event = "VimEnter",
    requires = {"kyazdani42/nvim-web-devicons", opt = true}
}

use {
    "norcalli/nvim-colorizer.lua",
    event = "BufReadPre",
    config = get_config("colorizer")
}

use {"windwp/nvim-autopairs", config = get_config("autopairs")}

use {
    "nvim-treesitter/nvim-treesitter",
    config = get_config("treesitter"),
    run = ":TSUpdate"
}

use "nvim-treesitter/nvim-treesitter-textobjects"

use {
    "hrsh7th/nvim-cmp",
    requires = {
        {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-buffer"}, {"hrsh7th/cmp-path"},
        {"hrsh7th/cmp-cmdline"}, {"hrsh7th/cmp-vsnip"},
        {"f3fora/cmp-spell", {"hrsh7th/cmp-calc"}}
    },
    config = get_config("cmp")
}

use {"hrsh7th/vim-vsnip", config = get_config("vsnip")}

use {"rafamadriz/friendly-snippets", requires = {{"hrsh7th/vim-vsnip"}}}

use {
    "mhartington/formatter.nvim",
    event = "BufWritePre",
    config = get_config("formatter")
}

-- requirement for Neogit
use {
    "sindrets/diffview.nvim",
    cmd = {
        "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles",
        "DiffviewFocusFiles"
    },
    config = get_config("diffview")
}

use {
    "TimUntersberger/neogit",
    requires = {"nvim-lua/plenary.nvim"},
    cmd = "Neogit",
    config = get_config("neogit")
}

use {"f-person/git-blame.nvim", config = get_config("git-blame")}

use {
    "lewis6991/gitsigns.nvim",
    requires = {"nvim-lua/plenary.nvim"},
    event = "BufReadPre",
    config = get_config("gitsigns")
}

use "p00f/nvim-ts-rainbow"

use {
    "kevinhwang91/nvim-bqf",
    requires = {{"junegunn/fzf", module = "nvim-bqf"}}
}

use {"nvim-telescope/telescope-fzf-native.nvim", run = "make"}

use {
    "akinsho/nvim-bufferline.lua",
    requires = "kyazdani42/nvim-web-devicons",
    event = "BufReadPre",
    config = get_config("bufferline")
}

use "famiu/bufdelete.nvim"

use {"neovim/nvim-lspconfig", config = get_config("lsp")}

use {"ray-x/lsp_signature.nvim", requires = {{"neovim/nvim-lspconfig"}}}

use {"onsails/lspkind-nvim", requires = {{"famiu/bufdelete.nvim"}}}

use {
    "simrat39/symbols-outline.nvim",
    cmd = {"SymbolsOutline"},
    config = get_config("symbols")
}

use {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = [[require("config/indent-blankline")]]
}

use {
    "akinsho/nvim-toggleterm.lua",
    keys = {"<C-y>", "<leader>fl", "<leader>gt"},
    config = get_config("toggleterm")
}

use "sotte/presenting.vim"

use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    cmd = {"TroubleToggle", "Trouble"},
    config = get_config("trouble")
}

use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    cmd = {"TodoTrouble", "TodoTelescope"},
    event = "BufReadPost",
    config = get_config("todo")
}

use {"ahmedkhalf/project.nvim", config = get_config("project")}

use "ironhouzi/starlite-nvim"

use {"folke/which-key.nvim", config = get_config("which")}

use "junegunn/vim-easy-align" -- no lua alternative

use {"rhysd/vim-grammarous", cmd = "GrammarousCheck"}

use {"RRethy/vim-illuminate", event = "CursorHold"}

use {
    "ptzz/lf.vim",
    requires = "voldikss/vim-floaterm",
    config = get_config("lf")
}

use {"NTBBloodbath/doom-one.nvim", config = get_config("doom-one")}

use {
    "karb94/neoscroll.nvim",
    keys = {"<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-e>", "zt", "zz", "zb"},
    config = get_config("neoscroll")
}

use {
    "ThePrimeagen/harpoon",
    requires = {"nvim-lua/plenary.nvim"},
    config = get_config("harpoon")
}

use {"folke/zen-mode.nvim", cmd = "ZenMode", config = get_config("zen-mode")}

use {"folke/twilight.nvim", config = get_config("twilight")}

use {"tweekmonster/startuptime.vim"}

use {"xiyaowong/nvim-transparent", config = get_config("transparent")}

use {"ggandor/lightspeed.nvim", event = "BufReadPre"}

use {"cuducos/yaml.nvim", ft = {"yaml"}}

use {
    "VonHeikemen/fine-cmdline.nvim",
    requires = {"MunifTanjim/nui.nvim"},
    config = get_config("fine-cmdline")
}

use {"ray-x/go.nvim", config = get_config("go")}

use {"LudoPinelli/comment-box.nvim", config = get_config("comment-box")}

use {"rcarriga/nvim-notify", config = get_config("notify")}

use {"echasnovski/mini.nvim", branch = "stable", config = get_config("mini")}

-- TODO: ????
-- https://github.com/glepnir/lspsaga.nvim
-- use 'glepnir/lspsaga.nvim'

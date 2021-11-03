local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_config(name)
    return string.format("require(\"config/%s\")", name)
end

if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git", "clone", "https://github.com/wbthomason/packer.nvim",
        install_path
    })
    execute "packadd packer.nvim"
end

return require("packer").startup(function(use)
    use "wbthomason/packer.nvim"

    use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
        config = get_config("telescope")
    }

    use {"kyazdani42/nvim-tree.lua", config = get_config("nvim-tree")}

    use {"numToStr/Navigator.nvim", config = get_config("navigator")}

    use {
        "nvim-lualine/lualine.nvim",
        config = get_config("lualine"),
        requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }

    use {"norcalli/nvim-colorizer.lua", config = get_config("colorizer")}

    use {"numToStr/Comment.nvim", config = get_config("comment")}

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
            {"hrsh7th/cmp-nvim-lsp"}, {"hrsh7th/cmp-buffer"},
            {"hrsh7th/cmp-path"}, {"hrsh7th/cmp-cmdline"},
            {"hrsh7th/cmp-vsnip"},
            {"f3fora/cmp-spell", {"hrsh7th/cmp-calc"}, {"hrsh7th/cmp-emoji"}}
        },
        config = get_config("cmp")
    }

    use {"hrsh7th/vim-vsnip", config = get_config("vsnip")}

    use {"rafamadriz/friendly-snippets", requires = {{"hrsh7th/vim-vsnip"}}}

    use {"mhartington/formatter.nvim", config = get_config("formatter")}

    use {"phaazon/hop.nvim", config = require"hop".setup()}

    use {
        "TimUntersberger/neogit",
        requires = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim"},
        config = [[require("config/neogit","config/diffview")]] -- TODO: enhance get_config function
    }
    use {"f-person/git-blame.nvim", config = get_config("git-blame")}
    use {
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = get_config("gitsigns")
    }

    use "p00f/nvim-ts-rainbow"

    use {"kevinhwang91/nvim-bqf", requires = {{"junegunn/fzf"}}}

    use {
        "akinsho/nvim-bufferline.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = get_config("bufferline")
    }

    use "famiu/bufdelete.nvim"

    use {"neovim/nvim-lspconfig", config = get_config("lsp")}
    use {"ray-x/lsp_signature.nvim", requires = {{"neovim/nvim-lspconfig"}}}
    use {"onsails/lspkind-nvim", requires = {{"famiu/bufdelete.nvim"}}}

    use {"simrat39/symbols-outline.nvim", config = get_config("symbols")}

    use {
        "lukas-reineke/indent-blankline.nvim",
        config = [[require("config/indent-blankline")]]
    }

    use {"akinsho/nvim-toggleterm.lua", config = get_config("toggleterm")}

    use {
        "blackCauldron7/surround.nvim",
        config = function()
            vim.g.surround_mappings_style = "surround"
            require"surround".setup {}
        end
    }

    use "sotte/presenting.vim"

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = get_config("trouble")
    }

    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = get_config("todo")
    }

    use {"ahmedkhalf/project.nvim", config = get_config("project")}

    use "ironhouzi/starlite-nvim"

    use {"folke/which-key.nvim", config = get_config("which")}

    use "junegunn/vim-easy-align" -- no lua alternative

    use "rhysd/vim-grammarous"

    use "RRethy/vim-illuminate"

    use {
        "ptzz/lf.vim",
        requires = "voldikss/vim-floaterm",
        config = get_config("lf")
    }

    use "marko-cerovac/material.nvim"

    use "folke/tokyonight.nvim"

    use "EdenEast/nightfox.nvim"

    use {"NTBBloodbath/doom-one.nvim", config = get_config("doom-one")}

    -- TODO: ????
    -- https://github.com/glepnir/lspsaga.nvim
    -- use 'glepnir/lspsaga.nvim'
    -- Too intrusive (fFtT, sS zZ, xX ...)
    -- https://github.com/ggandor/lightspeed.nvim
    -- use 'ggandor/lightspeed.nvim'

end)

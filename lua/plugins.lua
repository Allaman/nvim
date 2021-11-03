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
    -- Packer can manage itself https://github.com/wbthomason/packer.nvim
    use "wbthomason/packer.nvim"

    -- https://github.com/nvim-telescope/telescope.nvim
    use {
        "nvim-telescope/telescope.nvim",
        requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
        config = get_config("telescope")
    }

    -- https://github.com/kyazdani42/nvim-tree.lua
    use {"kyazdani42/nvim-tree.lua", config = get_config("nvim-tree")}

    -- https://github.com/numToStr/Navigator.nvim
    use {"numToStr/Navigator.nvim", config = get_config("navigator")}

    -- https://github.com/nvim-lualine/lualine.nvim
    use {
        "nvim-lualine/lualine.nvim",
        config = get_config("lualine"),
        requires = {"kyazdani42/nvim-web-devicons", opt = true}
    }

    -- https://github.com/norcalli/nvim-colorizer.lua
    use {"norcalli/nvim-colorizer.lua", config = get_config("colorizer")}

    -- https://github.com/numToStr/Comment.nvim
    use {"numToStr/Comment.nvim", config = get_config("comment")}

    -- https://github.com/windwp/nvim-autopairs
    use {"windwp/nvim-autopairs", config = get_config("autopairs")}

    -- https://github.com/nvim-treesitter/nvim-treesitter
    use {
        "nvim-treesitter/nvim-treesitter",
        config = get_config("treesitter"),
        run = ":TSUpdate"
    }

    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    use "nvim-treesitter/nvim-treesitter-textobjects"

    -- https://github.com/hrsh7th/nvim-cmp
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

    -- https://github.com/hrsh7th/vim-vsnip
    use {"hrsh7th/vim-vsnip", config = get_config("vsnip")}

    -- https://github.com/rafamadriz/friendly-snippets
    use {"rafamadriz/friendly-snippets", requires = {{"hrsh7th/vim-vsnip"}}}

    -- https://github.com/mhartington/formatter.nvim
    use {"mhartington/formatter.nvim", config = get_config("formatter")}

    -- https://github.com/phaazon/hop.nvim
    use {"phaazon/hop.nvim", config = require"hop".setup()}

    -- https://github.com/sindrets/diffview.nvim
    -- https://github.com/TimUntersberger/neogit
    use {
        "TimUntersberger/neogit",
        requires = {"nvim-lua/plenary.nvim", "sindrets/diffview.nvim"},
        config = [[require("config/neogit","config/diffview")]] -- TODO: enhance get_config function
    }
    -- https://github.com/f-person/git-blame.nvim
    use {"f-person/git-blame.nvim", config = get_config("git-blame")}
    -- https://github.com/lewis6991/gitsigns.nvim
    use {
        "lewis6991/gitsigns.nvim",
        requires = {"nvim-lua/plenary.nvim"},
        config = get_config("gitsigns")
    }

    -- https://github.com/p00f/nvim-ts-rainbow
    use "p00f/nvim-ts-rainbow"

    -- https://github.com/kevinhwang91/nvim-bqf
    -- fzf only used for bqf filter view
    use {"kevinhwang91/nvim-bqf", requires = {{"junegunn/fzf"}}}

    -- https://github.com/akinsho/nvim-bufferline.lua
    use {
        "akinsho/nvim-bufferline.lua",
        requires = "kyazdani42/nvim-web-devicons",
        config = get_config("bufferline")
    }

    -- https://github.com/famiu/bufdelete.nvim
    use "famiu/bufdelete.nvim"

    -- https://github.com/neovim/nvim-lspconfig
    use {"neovim/nvim-lspconfig", config = get_config("lsp")}
    -- https://github.com/ray-x/lsp_signature.nvim
    use {"ray-x/lsp_signature.nvim", requires = {{"neovim/nvim-lspconfig"}}}
    -- https://github.com/onsails/lspkind-nvim
    use {"onsails/lspkind-nvim", requires = {{"famiu/bufdelete.nvim"}}}

    -- https://github.com/simrat39/symbols-outline.nvim
    use {"simrat39/symbols-outline.nvim", config = get_config("symbols")}

    -- https://github.com/lukas-reineke/indent-blankline.nvim
    use {
        "lukas-reineke/indent-blankline.nvim",
        branch = lua,
        -- config = [[require("config/indent")]] TODO: I did not get to work an external config
        setup = function()
            vim.g.indent_blankline_char = "│"
            vim.g.indent_blankline_show_first_indent_level = true
            vim.g.indent_blankline_filetype_exclude = {
                "startify", "dashboard", "dotooagenda", "log", "fugitive",
                "gitcommit", "packer", "vimwiki", "markdown", "json", "txt",
                "vista", "help", "todoist", "NvimTree", "peekaboo", "git",
                "TelescopePrompt", "undotree", "flutterToolsOutline", "" -- for all buffers without a file type
            }
            vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
            vim.g.indent_blankline_show_trailing_blankline_indent = false
            vim.g.indent_blankline_show_current_context = true
            vim.g.indent_blankline_char_list = {"|", "¦", "┆", "┊"}
            vim.g.indent_blankline_space_char = " "
            vim.g.indent_blankline_context_patterns = {
                "class", "function", "method", "block", "list_literal",
                "selector", "^if", "^table", "if_statement", "while", "for"
            }
        end
    }

    -- https://github.com/akinsho/nvim-toggleterm.lua
    use {"akinsho/nvim-toggleterm.lua", config = get_config("toggleterm")}

    -- https://github.com/blackCauldron7/surround.nvim
    use {
        "blackCauldron7/surround.nvim",
        config = function()
            vim.g.surround_mappings_style = "surround"
            require"surround".setup {}
        end
    }

    -- https://github.com/sotte/presenting.vim
    use "sotte/presenting.vim"

    -- https://github.com/folke/trouble.nvim
    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = get_config("trouble")
    }

    -- https://github.com/folke/todo-comments.nvim
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = get_config("todo")
    }

    -- https://github.com/ahmedkhalf/project.nvim
    use {"ahmedkhalf/project.nvim", config = get_config("project")}

    -- https://github.com/ironhouzi/starlite-nvim
    use "ironhouzi/starlite-nvim"

    -- https://github.com/folke/which-key.nvim
    use {"folke/which-key.nvim", config = get_config("which")}

    -- https://github.com/junegunn/vim-easy-align
    -- no lua alternative
    use "junegunn/vim-easy-align"

    -- https://github.com/rhysd/vim-grammarous
    use "rhysd/vim-grammarous"

    -- https://github.com/RRethy/vim-illuminate
    use "RRethy/vim-illuminate"

    -- https://github.com/ptzz/lf.vim
    -- https://github.com/voldikss/vim-floaterm
    use {
        "ptzz/lf.vim",
        requires = "voldikss/vim-floaterm",
        config = get_config("lf")
    }

    -- https://github.com/marko-cerovac/material.nvim
    use "marko-cerovac/material.nvim"

    -- https://github.com/folke/tokyonight.nvim
    use "folke/tokyonight.nvim"

    -- https://github.com/EdenEast/nightfox.nvim
    use "EdenEast/nightfox.nvim"

    -- https://github.com/NTBBloodbath/doom-one.nvim
    use {"NTBBloodbath/doom-one.nvim", config = get_config("doom-one")}

    -- TODO: ????
    -- https://github.com/glepnir/lspsaga.nvim
    -- use 'glepnir/lspsaga.nvim'
    -- Too intrusive (fFtT, sS zZ, xX ...)
    -- https://github.com/ggandor/lightspeed.nvim
    -- use 'ggandor/lightspeed.nvim'

end)

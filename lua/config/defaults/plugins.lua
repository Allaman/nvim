return {
  plugins = {
    -- https://github.com/jackMort/ChatGPT.nvim
    chatgpt = {
      enable = false,
      opts = {},
    },
    -- https://github.com/zbirenbaum/copilot.lua
    copilot = {
      enable = false,
      disable_autostart = false,
    },
    lsp = {
      log = "off",
    },
    git = {
      -- which tool to use for handling git merge conflicts
      -- choose between "git-conflict" and "diffview" or "both"
      merge_conflict_tool = "git-conflict",
    },
    gp = {
      -- https://github.com/Robitx/gp.nvim
      enabled = false,
    },
    gopher = {
      -- https://github.com/olexsmir/gopher.nvim
      enable = false,
    },
    -- https://github.com/Allaman/kustomize.nvim
    kustomize = {
      dev = false,
      opts = {
        kinds = {
          -- setting those to false removes "clutter" but you cannot "jump" to a resource anymore
          show_filepath = true,
          show_line = true,
        },
      },
    },
    lazy = {
      dev = {
        path = "$HOME/workspace/github.com/",
      },
      disable_neovim_plugins = {
        -- "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        -- "tarPlugin",
        -- "tohtml",
        -- "tutor",
        -- "zipPlugin",
      },
    },
    lf = {
      -- https://github.com/lmburns/lf.nvim
      enable = false,
      replace_ntrw = 0,
      key_mappings = function()
        vim.keymap.set("n", "<leader>lf", "<cmd>Lf<cr>", { desc = "LF" })
      end,
    },
    ltex = {
      additional_lang = "de-DE", -- manually set a language in ltex-ls
    },
    noice = {
      enable = true, -- Noice heavily changes the Neovim UI ...
    },
    overseer = {
      -- https://github.com/stevearc/overseer.nvim
      enable = false,
    },
    spectre = {
      -- enable advanced search and replace
      -- https://github.com/nvim-pack/nvim-spectre
      enable = true,
    },
    symbol_usage = {
      enable = true,
      opts = {
        vt_position = "above", -- 'above'|'end_of_line'|'textwidth'
      },
    },
    tex = {
      vimtex_compiler_method = "tectonic", -- Tool to compile LaTex files
      vimtex_view_method = "skim", -- Tool to view PDFs generated from LaTex
    },
    trouble = {
      enabled = false,
    },
    -- https://github.com/folke/zen-mode.nvim
    zenmode = {
      enable = false,
    },
  },
}

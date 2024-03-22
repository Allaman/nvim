return {
  plugins = {
    alpha = {
      -- Number of recent files shown in dashboard
      -- 0 disables showing recent files
      dashboard_recent_files = 5,
      -- disable the header of the dashboard
      disable_dashboard_header = false,
      -- disable quick links of the dashboard
      disable_dashboard_quick_links = false,
      -- use mini.visits as recent files provider
      use_mini_visits = false,
    },
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
    emoji = {
      enable = false,
      enable_cmp_integration = false,
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
    harpoon = {
      -- https://github.com/ThePrimeagen/harpoon
      enable = false,
      key_mappings = function(harpoon)
        vim.keymap.set("n", "<leader>a", function()
          harpoon:list():append()
        end, { desc = "Harpoon append" })
        vim.keymap.set("n", "<leader>0", function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end, { desc = "Harpoon UI" })
        vim.keymap.set("n", "<leader>1", function()
          harpoon:list():select(1)
        end, { desc = "Harpoon 2" })
        vim.keymap.set("n", "<leader>2", function()
          harpoon:list():select(2)
        end, { desc = "Harpoon 2" })
        vim.keymap.set("n", "<leader>3", function()
          harpoon:list():select(3)
        end, { desc = "Harpoon 3" })
        vim.keymap.set("n", "<leader>4", function()
          harpoon:list():select(4)
        end, { desc = "Harpoon 4" })
      end,
    },
    indent_blankline = {
      enable = false,
      enable_scope = true,
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
    lualine = {
      -- https://github.com/nvim-lualine/lualine.nvim#extensions
      extensions = { "lazy" },
    },
    ltex = {
      additional_lang = "de-DE", -- manually set a language in ltex-ls
    },
    noice = {
      enable = true, -- Noice heavily changes the Neovim UI ...
    },
    oil = {
      --- https://github.com/stevearc/oil.nvim
      enable = false,
      key_mappings = function()
        vim.keymap.set("n", "_", "<cmd>Oil<cr>", { desc = "Open oil" })
      end,
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
      enable = false,
      opts = {},
    },
    -- https://github.com/folke/zen-mode.nvim
    zenmode = {
      enable = false,
    },
  },
}

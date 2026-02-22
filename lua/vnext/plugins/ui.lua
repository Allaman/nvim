return {

  { "nvim-lua/plenary.nvim", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "nvim-mini/mini.icons",
    lazy = true,
    opts = {},
    init = function()
      -- From https://github.com/LazyVim/LazyVim/blob/5115b585e7df4cedb519734ffc380b7e48a366f1/lua/lazyvim/util/mini.lua
      -- From https://github.com/LazyVim/LazyVim/blob/d35a3914bfc0c7c1000184585217d58a81f5da1a/lua/lazyvim/plugins/ui.lua#L310
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },

  {
    "Bekaboo/dropbar.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" }) -- no background for dropbar
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    -- dependencies = {
    --   { "rcarriga/nvim-notify" },
    -- },
    keys = {
      { "<leader>n", "", desc = "Noice" },
      { "<leader>nn", "<cmd>Noice all<cr>", desc = "Open Noice" },
      { "<leader>nd", "<cmd>Noice dismiss<cr>", desc = "Dismiss Notification" },
    },
    opts = {
      cmdline = {
        view = "cmdline", -- classic cmdline at the botton
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          -- ["cmp.entry.get_documentation"] = true, requires hrsh7th/nvim-cmp
        },
      },
      messages = {
        view_search = false, -- do not show search count as virtualtext
      },
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
  },

  {
    "catgoose/nvim-colorizer.lua",
    cmd = "ColorizerToggle",
    keys = {
      { "<leader>ux", "<cmd>ColorizerToggle<cr>", desc = "Colorizer" },
    },
    opts = {},
  },

  {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    priority = 1000,
    opts = {
      preset = "minimal",
      options = {
        show_source = {
          enabled = true,
        },
        multilines = {
          enabled = true,
        },
      },
    },
  },

  {
    "mistweaverco/kulala.nvim",
    keys = {
      { "<leader>Hs", desc = "Send request" },
      { "<leader>Ha", desc = "Send all requests" },
      { "<leader>Hb", desc = "Open scratchpad" },
    },
    ft = { "http", "rest" },
    opts = {
      global_keymaps = true,
      global_keymaps_prefix = "<leader>H",
      kulala_keymaps_prefix = "",
    },
  },

  {
    "j-morano/buffer_manager.nvim", -- just for good buffer cycling 🙈
    opts = {},
    keys = {
      { "<tab>", ":lua require('buffer_manager.ui').nav_next()<cr>", desc = "Next buffer" },
      { "<S-tab>", ":lua require('buffer_manager.ui').nav_prev()<cr>", desc = "Prev buffer" },
    },
  },

  {
    "hat0uma/csvview.nvim",
    ---@module "csvview"
    ---@type CsvView.Options
    opts = {
      parser = { comments = { "#", "//" } },
      keymaps = {
        -- Text objects for selecting fields
        textobject_field_inner = { "if", mode = { "o", "x" } },
        textobject_field_outer = { "af", mode = { "o", "x" } },
        -- Excel-like navigation:
        -- Use <Tab> and <S-Tab> to move horizontally between fields.
        -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
        -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
        -- jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
        -- jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
        -- jump_next_row = { "<Enter>", mode = { "n", "v" } },
        -- jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
      },
    },
    cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
  },

  {
    "ramilito/kubectl.nvim",
    version = "2.*",
    opt = {
      -- log_level = vim.log.levels.DEBUG,
      headers = {
        heartbeat = false,
        skew = {
          enabled = false,
        },
      },
    },
    dependencies = "saghen/blink.download",
    keys = {
      { "<leader>9", ":lua require('kubectl').toggle({ tab = true })<cr>", desc = "Kubectl" },
    },
    config = function(_, opts)
      require("kubectl").setup(opts)
    end,
  },
  {
    "savq/melange-nvim",
    priority = 1000,
    lazy = false,
    config = function()
      vim.cmd("colorscheme melange")
    end,
  },
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    enabled = false,
    lazy = false,
    config = function()
      require("tokyonight").setup()
      vim.cmd("colorscheme tokyonight-moon")
    end,
  },
  {
    "oskarnurm/koda.nvim",
    lazy = false,
    enabled = false,
    priority = 1000,
    opts = {
      colors = {
        bg = "#101010",
        fg = "#b0b0b0",
        dim = "#000000",
        line = "#777777",
        keyword = "#777777",
        comment = "#bcbcbc",
        border = "#ffffff",
        emphasis = "#ffffff",
        func = "#ffffff",
        string = "#ffffff",
        const = "#d9ba73",
        highlight = "#458ee6",
        info = "#8ebeec",
        success = "#86cd82",
        warning = "#d9ba73",
        danger = "#ff7676",
        green = "#14ba19",
        orange = "#f54d27",
        red = "#701516",
        pink = "#f2a4db",
        cyan = "#5abfb5",
      },
      on_highlights = function(hl, c)
        hl.LspReferenceText = { fg = c.highlight } -- change vim.lsp.buf.document_highlight()
      end,
    },
    config = function(_, opts)
      require("koda").setup(opts)
      vim.cmd("colorscheme koda")
    end,
  },
}

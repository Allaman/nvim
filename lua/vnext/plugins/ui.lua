return {

  { "nvim-lua/plenary.nvim", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },

  {
    "echasnovski/mini.icons",
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
  },

  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      -- NOTE: my mapping <leader>lf is soo good but in the LSP cluster
      {
        "<leader>lf",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open Yazi (file manager)",
      },
    },
    opts = {
      open_for_directories = true,
    },
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      -- {
      --   "rcarriga/nvim-notify",
      --   opts = {
      --     top_down = true,
      --   },
      -- },
    },
    keys = {
      { "<leader>n", "", desc = "Noice" },
      { "<leader>nn", "<cmd>Noice all<cr>", desc = "Open Noice" },
    },
    opts = {
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
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
  -- {
  --   "folke/tokyonight.nvim",
  --   priority = 1000,
  --   lazy = false,
  --   opts = {
  --     style = "moon",
  --   },
  --   config = function(_, opts)
  --     require("tokyonight").setup({ opts })
  --     vim.cmd("colorscheme tokyonight")
  --   end,
  -- },
}

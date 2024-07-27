local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "RRethy/nvim-treesitter-endwise",
    "mfussenegger/nvim-ts-hint-textobject",
    "windwp/nvim-ts-autotag",
  },
  config = function()
    local conf = vim.g.config
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      ensure_installed = conf.treesitter_ensure_installed,
      highlight = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<cr>",
          scope_incremental = false,
          node_incremental = "<cr>",
          node_decremental = "<bs>",
        },
      },
      endwise = {
        enable = true,
      },
      indent = { enable = true },
      autopairs = { enable = true },
    })

    require("nvim-ts-autotag").setup()
  end,
}

return M

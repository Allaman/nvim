return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "bash",
      "cmake",
      "css",
      "dockerfile",
      "go",
      "hcl",
      "html",
      "java",
      "javascript",
      "json",
      "jsonc",
      "kotlin",
      "ledger",
      "lua",
      "markdown",
      "markdown_inline",
      "query",
      "python",
      "regex",
      "terraform",
      "toml",
      "vim",
      "yaml",
    },
  },
  dependencies = {
    -- "RRethy/nvim-treesitter-endwise",
    -- "mfussenegger/nvim-ts-hint-textobject",
    -- "windwp/nvim-ts-autotag",
  },
  config = function(_, opts)
    ---@type TSConfig
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      ensure_installed = opts.ensure_installed,
      highlight = {
        enable = true,
      },
      -- endwise = {
      --   enable = true,
      -- },
      indent = { enable = true },
      autopairs = { enable = true },
    })

    -- require("nvim-ts-autotag").setup()
  end,
}

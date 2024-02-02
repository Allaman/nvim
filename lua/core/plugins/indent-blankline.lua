local conf = vim.g.config.plugins.indent_blankline
return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  enabled = conf.enable,
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    scope = {
      enabled = conf.enable_scope,
    },
    indent = {
      char = { "|", "¦", "┆", "┊" },
    },
    exclude = {
      filetypes = {
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
        "neo-tree",
        "peekaboo",
        "git",
        "TelescopePrompt",
        "undotree",
        "flutterToolsOutline",
        "", -- for all buffers without a file type
      },
      buftypes = {
        "terminal",
        "nofile",
      },
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)
  end,
}

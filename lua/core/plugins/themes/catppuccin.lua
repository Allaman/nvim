local catppuccin = require("catppuccin")

catppuccin.setup({
  default_integrations = false,
  integrations = {
    alpha = true,
    cmp = true,
    dap = true,
    dap_ui = true,
    dropbar = { enabled = true },
    fidget = false,
    gitsigns = true,
    harpoon = (vim.g.config.plugins.harpoon.enabled or false),
    headlines = true,
    indent_blankline = { enabled = true },
    lsp_trouble = (vim.g.config.plugins.harpoon.trouble or false),
    markdown = true,
    mason = true,
    mini = true,
    native_lsp = {
      enabled = true,
      virtual_text = {
        errors = { "italic" },
        hints = { "italic" },
        warnings = { "italic" },
        information = { "italic" },
      },
      underlines = {
        errors = { "underline" },
        hints = { "underline" },
        warnings = { "underline" },
        information = { "underline" },
      },
      inlay_hints = {
        background = true,
      },
    },
    neogit = true,
    neotree = true,
    noice = true,
    notify = true,
    overseer = true,
    symbols_outline = true,
    telescope = true,
    treesitter = true,
    which_key = true,
    window_picker = true,
  },
})

vim.cmd("colorscheme " .. vim.g.config.theme.catppuccin.variant)

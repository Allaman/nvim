local util = require("config.util")

util.pack("rachartier/tiny-inline-diagnostic.nvim")

require("tiny-inline-diagnostic").setup({
  preset = "minimal",
  options = {
    show_source = {
      enabled = true,
    },
    multilines = {
      enabled = true,
    },
  },
})

local gh = require("config.util").gh

vim.pack.add({ gh("folke/lazydev.nvim") })

require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
    { path = "snacks.nvim", words = { "Snacks" } },
  },
})

local blink = require("config.blink")

blink.add_provider("lazydev", {
  name = "LazyDev",
  module = "lazydev.integrations.blink",
  score_offset = 100,
})

blink.opts.sources.per_filetype.lua = {
  inherit_defaults = true,
  "lazydev",
}

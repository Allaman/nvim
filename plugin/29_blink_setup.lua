local blink_config = require("config.blink")

require("blink.cmp").setup(blink_config.opts)

vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})

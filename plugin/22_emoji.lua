local util = require("config.util")

local emoji_path = util.pack("allaman/emoji.nvim", { dev = true })
  or vim.pack.get({ "emoji.nvim" }, { info = false })[1].path

require("emoji").setup({
  enable_cmp_integration = true,

  plugin_path = vim.fs.dirname(emoji_path),
})

local blink = require("config.blink")

blink.add_default_source("emoji")

blink.add_provider("emoji", {
  name = "emoji",
  module = "blink.compat.source",

  transform_items = function(_, items)
    local kind = require("blink.cmp.types").CompletionItemKind.Text

    for i = 1, #items do
      items[i].kind = kind
    end

    return items
  end,
})

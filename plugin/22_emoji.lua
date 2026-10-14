local gh = require("config.util").gh

vim.pack.add({ gh("Allaman/emoji.nvim") })

local emoji_pack = vim.pack.get({ "emoji.nvim" }, {
  info = false,
})[1]

require("emoji").setup({
  enable_cmp_integration = true,

  plugin_path = emoji_pack and vim.fs.dirname(emoji_pack.path) or nil,
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

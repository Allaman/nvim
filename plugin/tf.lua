local util = require("config.util")

util.pack("allaman/tf.nvim", { dev = true })

---@module "tf"
---@type tf.ConfigPartial
local opts = {}

require("tf").setup(opts)

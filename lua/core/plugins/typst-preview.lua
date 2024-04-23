local user_config = vim.g.config.plugins.typst_preview or {}

local default_config = {
  enabled = false,
  opts = {},
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "chomosuke/typst-preview.nvim",
  enabled = config.enabled,
  ft = "typst",
  build = function()
    require("typst-preview").update()
  end,
}

local user_config = vim.g.config.plugins.luapad or {}

local default_config = {
  -- stylua: ignore start
  keys = {
    { "<leader>mL", function() require("luapad").init() end, desc = "Luapad", },
  },
  -- stylua: ignore end
  opts = {},
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "rafcamlet/nvim-luapad",
  keys = config.keys,
  opts = config.opts,
}

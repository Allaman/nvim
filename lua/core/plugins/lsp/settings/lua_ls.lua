-- https://github.com/sumneko/lua-language-server/blob/master/locale/en-us/setting.lua
local opts = {
  format = {
    enable = false, -- let null-ls handle the formatting
  },
  diagnostics = { globals = { "vim" } },
  telemetry = { enable = false },
}

return opts

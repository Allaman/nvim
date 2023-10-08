-- https://github.com/sumneko/lua-language-server/blob/master/locale/en-us/setting.lua
local opts = {
  cmd = { "lua-language-server" },
  format = {
    enable = false, -- let null-ls handle the formatting
  },
  filetypes = { "lua" },
  runtime = {
    version = "LuaJIT",
    path = vim.split(package.path, ";"),
  },
  completion = { enable = true, callSnippet = "Replace" },
  diagnostics = {
    -- enable = true,
    -- globals = { "vim", "describe" },
    globals = {
      "vim",
      "nnoremap",
      "vnoremap",
      "inoremap",
      "tnoremap",
      "use",
    },
  },
  workspace = {
    checkThirdParty = false,
    -- adjust these two values if your performance is not optimal
    maxPreload = 2000,
    preloadFileSize = 1000,
  },
  telemetry = { enable = false },
}

return opts

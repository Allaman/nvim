local M = {
  "SmiteshP/nvim-navic",
  lazy = true,
  init = require("core.utils.functions").on_attach(function(client, buffer)
    if client.server_capabilities.documentSymbolProvider then
      require("nvim-navic").attach(client, buffer)
    end
  end),
}

return M

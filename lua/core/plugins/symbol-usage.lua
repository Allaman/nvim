local utils = require("core.utils.functions")
local event
if utils.isNeovimVersionsatisfied(10) then
  event = "LspAttach"
else
  event = "BufReadPre"
end

return {
  "Wansmer/symbol-usage.nvim",
  event = event,
  enabled = vim.g.config.plugins.symbol_usage.enable,
  config = function()
    require("symbol-usage").setup()
  end,
}

local utils = require("core.utils.functions")

return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPre", "BufNewFile" },
  enabled = utils.isNeovimVersionsatisfied(10),
}

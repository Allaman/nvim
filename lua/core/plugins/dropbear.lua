local utils = require("utils.functions")

return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPost", "BufNewFile" },
  enabled = utils.isNeovimVersionsatisfied(10),
}

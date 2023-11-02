local utils = require("utils.functions")

return {
  "Bekaboo/dropbar.nvim",
  enabled = utils.isNeovimVersionsatisfied(10),
}

local utils = require("core.utils.functions")

return {
  "Bekaboo/dropbar.nvim",
  enabled = utils.isNeovimVersionsatisfied(10),
}

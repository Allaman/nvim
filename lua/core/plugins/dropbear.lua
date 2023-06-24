local utils = require("core.utils.functions")

return {
  "Bekaboo/dropbar.nvim",
  event = { "BufReadPre", "BufNewFile" },
  enable = utils.checkMinimumNeovimVersion(10),
}

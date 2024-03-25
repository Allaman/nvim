local conform = require("config.defaults.conform")
local lint = require("config.defaults.lint")
local mason = require("config.defaults.mason")
local options = require("config.defaults.options")
local theme = require("config.defaults.theme")
local treesitter = require("config.defaults.treesitter")

local M = {}

M.load = function()
  return vim.tbl_deep_extend(
    "force",
    require("config.defaults.plugins"),
    conform,
    lint,
    mason,
    options,
    theme,
    treesitter
  )
end

return M

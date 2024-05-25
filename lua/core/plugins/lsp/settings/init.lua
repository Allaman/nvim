local M = {}

M.lua = require("core.plugins.lsp.settings.lua_ls")
M.gopls = require("core.plugins.lsp.settings.gopls")
M.json = require("core.plugins.lsp.settings.jsonls")
M.tex = require("core.plugins.lsp.settings.tex")
M.yaml = require("core.plugins.lsp.settings.yaml")
M.ltex = require("core.plugins.lsp.settings.ltex")

return M

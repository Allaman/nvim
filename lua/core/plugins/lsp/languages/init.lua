local M = {}

M.lua = require("core.plugins.lsp.languages.lua_ls")
M.json = require("core.plugins.lsp.languages.jsonls")
M.tex = require("core.plugins.lsp.languages.tex")
M.yaml = require("core.plugins.lsp.languages.yaml")
M.ltex = require("core.plugins.lsp.languages.ltex")

return M

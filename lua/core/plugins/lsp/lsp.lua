local conf = vim.g.config
local nvim_lsp = require("lspconfig")
local utils = require("core.plugins.lsp.utils")
local lsp_settings = require("core.plugins.lsp.settings")

-- blink or cmp
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
local has_blink, blink = pcall(require, "blink.cmp")
local capabilities = vim.tbl_deep_extend(
  "force",
  {},
  vim.lsp.protocol.make_client_capabilities(),
  has_cmp and cmp_nvim_lsp.default_capabilities() or {},
  has_blink and blink.get_lsp_capabilities() or {}
)

require("utils.functions").on_attach(function(client, buffer)
  require("core.plugins.lsp.keys").on_attach(client, buffer)
  if client.name == "gopls" then
    -- workaround for gopls not supporting semanticTokensProvider
    -- https://github.com/golang/go/issues/54531#issuecomment-1464982242
    if not client.server_capabilities.semanticTokensProvider then
      local semantic = client.config.capabilities.textDocument.semanticTokens
      client.server_capabilities.semanticTokensProvider = {
        full = true,
        legend = {
          tokenTypes = semantic.tokenTypes,
          tokenModifiers = semantic.tokenModifiers,
        },
        range = true,
      }
    end
  end
end)

if conf.plugins.lsp.log == "on" then
  vim.lsp.set_log_level("debug")
end

for _, lsp in ipairs(conf.lsp_servers) do
  nvim_lsp[lsp].setup({
    before_init = function(_, config)
      if lsp == "pyright" then
        config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
      end
    end,
    autostart = lsp ~= "ltex",
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = {
      json = lsp_settings.json,
      Lua = lsp_settings.lua,
      ltex = lsp_settings.ltex,
      gopls = lsp_settings.gopls,
      redhat = { telemetry = { enabled = false } },
      texlab = lsp_settings.tex,
      yaml = lsp_settings.yaml,
    },
  })
end

vim.api.nvim_create_user_command(
  "LtexLang",
  "lua require('core.plugins.lsp.utils').set_ltex_lang(<q-args>)",
  { nargs = 1, desc = "Set ltex-ls language" }
)
vim.keymap.set(
  "n",
  "<leader>mx",
  "<cmd>lua require('core.plugins.lsp.utils').set_ltex_lang(vim.g.config.plugins.ltex.additional_lang)<cr>",
  { desc = "Set ltex-ls language" }
)

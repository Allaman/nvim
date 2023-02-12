local nvim_lsp = require("lspconfig")
local utils = require("core.plugins.lsp.utils")
local languages = require("core.plugins.lsp.languages")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autoclompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local servers = {
  "bashls",
  "dockerls",
  "jsonls",
  "ltex",
  "marksman",
  "pyright",
  "lua_ls",
  "terraformls",
  "texlab",
  "tsserver",
  "yamlls",
}

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = function(client, bufnr)
      utils.custom_lsp_attach(client, bufnr)
    end,
    before_init = function(_, config)
      if lsp == "pyright" then
        config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
      end
    end,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = {
      json = languages.json,
      Lua = languages.lua,
      ltex = languages.ltx,
      redhat = { telemetry = { enabled = false } },
      texlab = languages.tex,
      yaml = languages.yaml,
    },
  })
end

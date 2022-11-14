local nvim_lsp = require("lspconfig")
local utils = require("config.lsp.utils")
local languages = require("config.lsp.languages")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autoclompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
-- enable folding capabilities for nvim-ufo
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local servers = {
  "bashls",
  "dockerls",
  "jsonls",
  "marksman",
  "pyright",
  "sumneko_lua",
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
      redhat = { telemetry = { enabled = false } },
      texlab = languages.tex,
      yaml = languages.yaml,
    },
  })
end

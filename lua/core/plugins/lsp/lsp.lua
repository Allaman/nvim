local conf = vim.g.config
local nvim_lsp = require("lspconfig")
local utils = require("core.plugins.lsp.utils")
local lsp_settings = require("core.plugins.lsp.settings")

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- enable autoclompletion via nvim-cmp
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("core.utils.functions").on_attach(function(client, buffer)
  require("core.plugins.lsp.keys").on_attach(client, buffer)
end)

for _, lsp in ipairs(conf.lsp_servers) do
  if lsp == "rust_analyzer" then
    vim.notify("rust_analyzer is managed by rust-tools", vim.log.levels.INFO, { title = "LSP config" })
    goto continue
  end
  nvim_lsp[lsp].setup({
    before_init = function(_, config)
      if lsp == "pyright" then
        config.settings.python.pythonPath = utils.get_python_path(config.root_dir)
      end
    end,
    capabilities = capabilities,
    flags = { debounce_text_changes = 150 },
    settings = {
      json = lsp_settings.json,
      Lua = lsp_settings.lua,
      ltex = lsp_settings.ltex,
      redhat = { telemetry = { enabled = false } },
      texlab = lsp_settings.tex,
      yaml = lsp_settings.yaml,
    },
  })
  ::continue::
end

vim.api.nvim_create_user_command(
  "LtexLang",
  "lua require('core.plugins.lsp.utils').set_ltex_lang(<q-args>)",
  { nargs = 1, desc = "Set ltex-ls language" }
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>mx",
  "<cmd>lua require('core.plugins.lsp.utils').set_ltex_lang(vim.g.config.plugins.ltex.additional_lang)<cr>",
  { desc = "Set ltex-ls language" }
)

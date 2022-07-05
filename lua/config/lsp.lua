local nvim_lsp = require("lspconfig")

-- detect python venv
-- https://github.com/neovim/nvim-lspconfig/issues/500#issuecomment-851247107
local util = require("lspconfig/util")
local path = util.path
local function get_python_path(workspace)
  -- Use activated virtualenv.
  if vim.env.VIRTUAL_ENV then
    return path.join(vim.env.VIRTUAL_ENV, "bin", "python")
  end
  -- Find and use virtualenv in workspace directory.
  for _, pattern in ipairs({ "*", ".*" }) do
    local match = vim.fn.glob(path.join(workspace, pattern, "pyvenv.cfg"))
    if match ~= "" then
      return path.join(path.dirname(match), "bin", "python")
    end
  end
  -- Fallback to system Python.
  return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

local servers = {
  "bashls",
  "dockerls",
  "jsonls",
  "pyright",
  "sumneko_lua",
  "terraformls",
  "texlab",
  "tsserver",
  "yamlls",
}
-- Use a loop to conveniently call 'setup' on multiple servers
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = function(client, bufnr)
      require("functions").custom_lsp_attach(client, bufnr)
    end,
    before_init = function(_, config)
      if lsp == "pyright" then
        config.settings.python.pythonPath = get_python_path(config.root_dir)
      end
    end,
    capabilities = capabilities,
    settings = {
      json = {
        format = { enabled = false },
        schemas = {
          {
            description = "ESLint config",
            fileMatch = { ".eslintrc.json", ".eslintrc" },
            url = "http://json.schemastore.org/eslintrc",
          },
          {
            description = "Package config",
            fileMatch = { "package.json" },
            url = "https://json.schemastore.org/package",
          },
          {
            description = "Packer config",
            fileMatch = { "packer.json" },
            url = "https://json.schemastore.org/packer",
          },
          {
            description = "Renovate config",
            fileMatch = {
              "renovate.json",
              "renovate.json5",
              ".github/renovate.json",
              ".github/renovate.json5",
              ".renovaterc",
              ".renovaterc.json",
            },
            url = "https://docs.renovatebot.com/renovate-schema",
          },
          {
            description = "OpenApi config",
            fileMatch = { "*api*.json" },
            url = "https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json",
          },
        },
      },
      Lua = {
        cmd = { "lua-language-server" },
        filetypes = { "lua" },
        runtime = {
          version = "LuaJIT",
        },
        completion = { enable = true, callSnippet = "Both" },
        diagnostics = {
          enable = true,
          globals = { "vim", "describe" },
        },
        workspace = {
          library = {
            vim.api.nvim_get_runtime_file("", true),
          },
          -- adjust these two values if your performance is not optimal
          maxPreload = 2000,
          preloadFileSize = 1000,
        },
        telemetry = { enable = false },
      },
      redhat = { telemetry = { enabled = false } },
      texlab = {
        auxDirectory = ".",
        bibtexFormatter = "texlab",
        build = {
          args = {
            "--keep-intermediates",
            "--keep-logs",
            "--synctex",
            "%f",
          },
          executable = "tectonic",
          forwardSearchAfter = false,
          onSave = false,
        },
        chktex = { onEdit = false, onOpenAndSave = false },
        diagnosticsDelay = 300,
        formatterLineLength = 80,
        forwardSearch = { args = {} },
        latexFormatter = "latexindent",
        latexindent = { modifyLineBreaks = false },
      },
      yaml = {
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        },
        schemas = {
          kubernetes = "*.yaml",
          ["http://json.schemastore.org/github-workflow"] = ".github/workflows/*",
          ["http://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
          ["http://json.schemastore.org/ansible-stable-2.9"] = "roles/tasks/*.{yml,yaml}",
          ["http://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
          ["http://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
          ["http://json.schemastore.org/ansible-playbook"] = "*play*.{yml,yaml}",
          ["http://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
          ["https://json.schemastore.org/dependabot-v2"] = ".github/dependabot.{yml,yaml}",
          ["https://json.schemastore.org/gitlab-ci"] = "*gitlab-ci*.{yml,yaml}",
          ["https://raw.githubusercontent.com/OAI/OpenAPI-Specification/main/schemas/v3.1/schema.json"] = "*api*.{yml,yaml}",
          ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "*docker-compose*.{yml,yaml}",
          ["https://raw.githubusercontent.com/argoproj/argo-workflows/master/api/jsonschema/schema.json"] = "*flow*.{yml,yaml}",
        },
        format = { enabled = false },
        validate = false, -- TODO: conflicts between Kubernetes resources and kustomization.yaml
        completion = true,
        hover = true,
      },
    },
    flags = { debounce_text_changes = 150 },
  })
end

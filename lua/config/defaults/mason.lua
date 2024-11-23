-- Tools that should be installed by Mason
-- LSPs that should be installed by Mason-lspconfig
return {
  lsp_servers = {
    "bashls",
    "dockerls",
    "jsonls",
    "gopls",
    "helm_ls",
    "ltex",
    "marksman",
    "pyright",
    "lua_ls",
    "terraformls",
    "texlab",
    "ts_ls",
    "typst_lsp",
    "yamlls",
  },

  tools = {
    -- Formatter
    "isort",
    "prettier",
    "stylua",
    "shfmt",
    "taplo",
    "typstfmt",
    -- Linter
    "hadolint",
    "eslint_d",
    "shellcheck",
    "selene",
    "tflint",
    "yamllint",
    "ruff",
    -- DAP
    "debugpy",
    "delve",
    "codelldb",
    -- Go
    "gofumpt",
    "goimports",
    "gomodifytags",
    "golangci-lint",
    "gotests",
    "iferr",
    "impl",
  },
}

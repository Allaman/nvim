local utils = require("core.utils")
M = {}

DIAGNOSTICS_ACTIVE = true -- must be global since the toggle function is called in which.lua
-- toggle diagnostics line
M.toggle_diagnostics = function()
  DIAGNOSTICS_ACTIVE = not DIAGNOSTICS_ACTIVE
  if DIAGNOSTICS_ACTIVE then
    vim.diagnostic.show()
  else
    vim.diagnostic.hide()
  end
end

AUTOFORMAT_ACTIVE = true
-- toggle null-ls's autoformatting
M.toggle_autoformat = function()
  require("core.utils").notify("Toggling autoformatting", 1, "lsp.utils")
  AUTOFORMAT_ACTIVE = not AUTOFORMAT_ACTIVE
end

-- detect python venv
-- https://github.com/neovim/nvim-lspconfig/issues/500#issuecomment-851247107
local util = require("lspconfig/util")
local path = util.path
function M.get_python_path(workspace)
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

local function disable_diagnostics(bufnr, message)
  utils.notify("Disabling diagnostics for HelmRelease files", 1, "lsp/utils")
  vim.diagnostic.reset(bufnr)
  vim.diagnostic.disable(bufnr)
end

local function handle_helm_templates(bufnr)
  local bufferData = vim.api.nvim_buf_get_text(bufnr, 0, 0, -1, -1, {})
  local bufferString = table.concat(bufferData, "\n")
  -- usually Helm files are in a template folder
  -- TODO: more robust and elegant check
  if string.find(bufferString, "kind: HelmRelease") then
    disable_diagnostics(bufnr, "Disabling diagnostics for HelmRelease files")
  end
end

local function handle_docker_compose(bufnr)
  local bufName = vim.api.nvim_buf_get_name(bufnr)
  -- TODO: more robust and elegant check
  -- search dor docker-compose.yaml does not work!
  if string.find(bufName, "compose.yaml") then
    disable_diagnostics(bufnr, "Disabling diagnostics for docker-compose files")
  end
end

local function handle_helm_releases(bufnr)
  local bufName = vim.api.nvim_buf_get_name(bufnr)
  -- TODO: more robust and elegant check
  if string.find(bufName, "templates") then
    disable_diagnostics(bufnr, "Disabling diagnostics for Helm template files")
  end
end

local function handle_kustomization(bufnr)
  local bufName = vim.api.nvim_buf_get_name(bufnr)
  -- TODO: more robust and elegant check
  if string.find(bufName, "kustomization.yaml") then
    disable_diagnostics(bufnr, "Disabling diagnostics for kustomization.yaml")
  end
end

function M.custom_lsp_attach(client, bufnr)
  -- disable formatting for LSP clients as this is handled by null-ls
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  -- enable navic for displaying current code context
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
  -- TODO: this workaround is not sufficient and bugyy
  -- handle_helm_templates(bufnr)
  -- handle_kustomization(bufnr)
  -- handle_docker_compose(bufnr)
  -- handle_helm_releases(bufnr)
  local wk = require("which-key")
  local default_options = { silent = true }
  wk.register({
    l = {
      name = "LSP",
      D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go To Declaration" },
      I = {
        "<cmd>lua vim.lsp.buf.implementation()<cr>",
        "Show implementations",
      },
      R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
      a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
      d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go To Definition" },
      e = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
      -- f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
      i = { "<cmd>LspInfo<cr>", "Connected Language Servers" },
      k = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover Commands" },
      l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Line Diagnostics" },
      n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
      p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev Diagnostic" },
      q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix Diagnostics" },
      r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
      t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
      w = {
        name = "workspaces",
        a = {
          "<cmd>lua vim.lsp.buf.add_workspace_folder()<cr>",
          "Add Workspace Folder",
        },
        d = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
        l = {
          "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<cr>",
          "List Workspace Folders",
        },
        r = {
          "<cmd>lua vim.lsp.buf.remove_workspace_folder()<cr>",
          "Remove Workspace Folder",
        },
        s = {
          "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
          "Workspace Symbols",
        },
      },
    },
  }, { prefix = "<leader>", mode = "n", default_options })
end

return M

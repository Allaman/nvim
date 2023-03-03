local utils = require("core.utils.functions")
M = {}

-- must be global or the initial state is not working
VIRTUAL_TEXT_ACTIVE = true
-- toggle displaying virtual text
M.toggle_virtual_text = function()
  VIRTUAL_TEXT_ACTIVE = not VIRTUAL_TEXT_ACTIVE
  utils.notify(string.format("Virtualtext %s", VIRTUAL_TEXT_ACTIVE and "on" or "off"), 1, "lsp/utils.lua")
  vim.diagnostic.show(nil, 0, nil, { virtual_text = VIRTUAL_TEXT_ACTIVE })
end

-- must be global or the initial state is not working
AUTOFORMAT_ACTIVE = true
-- toggle null-ls's autoformatting
M.toggle_autoformat = function()
  AUTOFORMAT_ACTIVE = not AUTOFORMAT_ACTIVE
  require("core.utils.functions").notify(
    string.format("Autoformatting %s", AUTOFORMAT_ACTIVE and "on" or "off"),
    1,
    "lsp.utils"
  )
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
return M

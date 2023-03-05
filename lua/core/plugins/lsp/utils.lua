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

return M

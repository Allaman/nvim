local cmd = vim.cmd
local fn = vim.fn

local M = {}

M.notify = function(message, level, title)
  local notify_options = {
    title = title,
    timeout = 2000,
  }
  require("notify")(message, level, notify_options)
end

-- check if a variable is not empty nor nil
M.isNotEmpty = function(s)
  return s ~= nil and s ~= ""
end

-- toggle quickfixlist
M.toggle_qf = function()
  local windows = fn.getwininfo()
  local qf_exists = false
  for _, win in pairs(windows) do
    if win["quickfix"] == 1 then
      qf_exists = true
    end
  end
  if qf_exists == true then
    cmd("cclose")
    return
  end
  if M.isNotEmpty(fn.getqflist()) then
    cmd("copen")
  end
end

-- toggle colorcolumn
M.toggle_colorcolumn = function()
  local value = vim.api.nvim_get_option_value("colorcolumn", {})
  if value == "" then
    M.notify("Enable colocolumn", "info", "functions.lua")
    vim.api.nvim_set_option_value("colorcolumn", "79", {})
  else
    M.notify("Disable colocolumn", "info", "functions.lua")
    vim.api.nvim_set_option_value("colorcolumn", "", {})
  end
end

-- move over a closing element in insert mode
M.escapePair = function()
  local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
  local line = vim.api.nvim_get_current_line()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local after = line:sub(col + 1, -1)
  local closer_col = #after + 1
  local closer_i = nil
  for i, closer in ipairs(closers) do
    local cur_index, _ = after:find(closer)
    if cur_index and (cur_index < closer_col) then
      closer_col = cur_index
      closer_i = i
    end
  end
  if closer_i then
    vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
  else
    vim.api.nvim_win_set_cursor(0, { row, col + 1 })
  end
end

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
  M.notify("Toggling autoformatting", "info", "functions.lua")
  AUTOFORMAT_ACTIVE = not AUTOFORMAT_ACTIVE
end

--@author kikito
---@see https://codereview.stackexchange.com/questions/268130/get-list-of-buffers-from-current-neovim-instance
function M.get_listed_buffers()
  local buffers = {}
  local len = 0
  for buffer = 1, vim.fn.bufnr("$") do
    if vim.fn.buflisted(buffer) == 1 then
      len = len + 1
      buffers[len] = buffer
    end
  end

  return buffers
end

function M.bufdelete(bufnum)
  require("bufdelete").bufdelete(bufnum, true)
end

-- when there is no buffer left show Alpha dashboard
vim.api.nvim_create_augroup("alpha_on_empty", { clear = true })
vim.api.nvim_create_autocmd("User", {
  pattern = "BDeletePre",
  group = "alpha_on_empty",
  callback = function(event)
    local found_non_empty_buffer = false
    local buffers = M.get_listed_buffers()

    for _, bufnr in ipairs(buffers) do
      if not found_non_empty_buffer then
        local name = vim.api.nvim_buf_get_name(bufnr)
        local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")

        if bufnr ~= event.buf and name ~= "" and ft ~= "Alpha" then
          found_non_empty_buffer = true
        end
      end
    end

    if not found_non_empty_buffer then
      vim.cmd([[:Alpha]])
    end
  end,
})

function M.custom_lsp_attach(client, bufnr)
  -- disable formatting for LSP clients as this is handled by null-ls
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  -- enable navic for displaying current code context
  if client.server_capabilities.documentSymbolProvider then
    require("nvim-navic").attach(client, bufnr)
  end
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

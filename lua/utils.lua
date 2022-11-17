local cmd = vim.cmd
local fn = vim.fn

local M = {}

M.notify = function(message, level, title)
  local notify_options = {
    title = title,
    timeout = 2000,
  }
  vim.api.nvim_notify(message, level, notify_options)
end

-- check if a variable is not empty nor nil
M.isNotEmpty = function(s)
  return s ~= nil and s ~= ""
end

--- Check if path exists
M.path_exists = function(path)
  local ok = vim.loop.fs_stat(path)
  return ok
end

-- Return telescope files command
M.telescope_find_files = function()
  local path = vim.loop.cwd() .. "/.git"
  if M.path_exists(path) then
    return "Telescope git_files"
  else
    return "Telescope find_files"
  end
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

-- @author kikito
-- @see https://codereview.stackexchange.com/questions/268130/get-list-of-buffers-from-current-neovim-instance
-- currently not used
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

function M.map(mode, l, r, opts)
  opts = opts or {}
  vim.keymap.set(mode, l, r, opts)
end

return M

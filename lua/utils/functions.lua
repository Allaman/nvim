local cmd = vim.cmd
local fn = vim.fn

local M = {}

---Return OS
---@return string
M.getOS = function()
  local handle = io.popen("uname -s")
  if handle == nil then
    vim.notify("Error while opening handler", vim.log.levels.ERROR)
    return ""
  end
  local uname = handle:read("*a")
  handle:close()
  uname = uname:gsub("%s+", "")
  if uname == "Darwin" then
    return "Darwin"
  elseif uname == "NixOS" then
    return "NixOS"
  elseif uname == "Linux" then
    return "Linux"
  else
    return ""
  end
end

--- Check if the minimum Neovim version is satisfied
--- Expects only the minor version, e.g. "9" for 0.9.1
---@param version number
---@return boolean
M.isNeovimVersionsatisfied = function(version)
  return version <= tonumber(vim.version().minor)
end

---checks if a command is available
---@param command string
---@return boolean
M.isExecutableAvailable = function(command)
  return vim.fn.executable(command) == 1
end

---notify
---@param message string
---@param level integer
---@param title string
M.notify = function(message, level, title)
  local notify_options = {
    title = title,
    timeout = 2000,
  }
  vim.api.nvim_notify(message, level, notify_options)
end

-- Check if a variable is not empty nor nil
M.isNotEmpty = function(s)
  return s ~= nil and s ~= ""
end

--- Check if path exists
M.path_exists = function(path)
  return vim.uv.fs_stat(path)
end

-- toggle quickfixlist
M.toggle_qf = function()
  local windows = fn.getwininfo()
  if windows == nil then
    return
  end
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
    M.notify("Enable colocolumn", 1, "functions.lua")
    vim.api.nvim_set_option_value("colorcolumn", "79", {})
  else
    M.notify("Disable colocolumn", 1, "functions.lua")
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

---@param on_attach fun(client, buffer)
function M.on_attach(on_attach)
  vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
      local buffer = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      on_attach(client, buffer)
    end,
  })
end

---get the path of the user's home directory
---@return string
function M.get_home()
  return os.getenv("XDG_CONFIG_HOME")
    or os.getenv("HOME")
    or os.getenv("USERPROFILE")
    or (os.getenv("HOMEDRIVE") .. os.getenv("HOMEPATH"))
end

---load user config file .nvim_config.lua
---@return table
function M.load_user_config()
  local home = M.get_home()
  local config_file = home .. M.path_separator() .. ".nvim_config.lua"
  local ok, err = pcall(dofile, config_file)
  if not ok then
    M.notify("Can not load user config: " .. err, vim.log.levels.INFO, "utils")
    return {}
  else
    return dofile(config_file)
  end
end

---returns OS dependent path separator
---@return string
M.path_separator = function()
  local is_windows = vim.fn.has("win32") == 1
  if is_windows == true then
    return "\\"
  else
    return "/"
  end
end

---Merge two tables into the first table
---@param t1 table
---@param t2 table
---@return table
M.merge_tables = function(t1, t2)
  for k, v in pairs(t2) do
    if (type(v) == "table") and (type(t1[k] or false) == "table") then
      M.merge_tables(t1[k], t2[k])
    else
      t1[k] = v
    end
  end
  return t1
end

---returns the number of items in a table
---@param t table
---@return integer
M.table_length = function(t)
  local count = 0
  for _ in pairs(t) do
    count = count + 1
  end
  return count
end

M.stopLSP = function(lsp_name)
  for _, client in ipairs(vim.lsp.get_clients()) do
    if client.name == lsp_name then
      vim.lsp.stop_client(client.id)
      M.notify("Stopping LSP " .. lsp_name, vim.log.levels.INFO, "Utils")
      break
    end
  end
end

M.startLSP = function(lsp_name)
  require("lspconfig")[lsp_name].setup({})
end

---check if nested config is not nil
---@param config any
---@param ... string
---@return any
M.safe_nested_config = function(config, ...)
  local elements = { ... }
  local node = config
  for i = 1, #elements do
    node = node[elements[i]]
    if node == nil then
      return nil
    end
  end
  return node
end

---returns the value of a deeply nested table (if it exists)
---@param tbl table
---@param key_path string
---@return string|nil
M.get_nested_value = function(tbl, key_path)
  local keys = vim.split(key_path, ".", { plain = true })
  local value = tbl

  for _, key in ipairs(keys) do
    if value[key] then
      value = value[key]
    else
      return nil -- key path is invalid
    end
  end

  return value
end

return M

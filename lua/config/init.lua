-- inspired by https://github.com/LunarVim/LunarVim/tree/master
-- but heavily stripped down
local utils = require("utils.functions")

-- TODO:
local function validate_config(config) end

---load user config file .nvim_config.lua
---@return table
local function load_user_config()
  local home = os.getenv("XDG_CONFIG_HOME")
    or os.getenv("HOME")
    or os.getenv("USERPROFILE")
    or (os.getenv("HOMEDRIVE") .. os.getenv("HOMEPATH"))
  local config_file = home .. utils.path_separator() .. ".nvim_config.lua"
  local ok, err = pcall(dofile, config_file)
  if not ok then
    M.notify("Can not load user config: " .. err, vim.log.levels.INFO, "utils")
    return {}
  else
    return dofile(config_file)
  end
end

local function init()
  local user_config = load_user_config()
  validate_config(user_config)

  -- Merge defaults and user config
  vim.g.config = utils.merge_tables(require("config.defaults"), user_config)

  -- configure vim.opt
  for k, v in pairs(vim.g.config.options) do
    vim.opt[k] = v
  end

  -- autocmds
  require("config.autocmds")
  -- globals
  require("utils.globals")
  -- lazy.nvim
  require("config.lazy")
  -- global mappings (must be loaded after lazy)
  require("config.mappings")
end

init()

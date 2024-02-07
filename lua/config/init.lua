-- inspired by https://github.com/LunarVim/LunarVim/tree/master
-- but heavily stripped down
local utils = require("utils.functions")

-- TODO:
local function validate_config(config) end

local function init()
  local user_config = utils.load_user_config()

  if next(user_config) ~= nil then
    validate_config(user_config)
    -- Merge defaults and user config
    vim.g.config = utils.merge_tables(require("config.defaults"), user_config)
  else
    vim.g.config = require("config.defaults")
  end

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

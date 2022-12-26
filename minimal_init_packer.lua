-- Adopted from https://github.com/folke/noice.nvim/wiki/Minimal-%60init.lua%60-to-Reproduce-an-Issue
-- use with nvim -u minimal_init_packer.lua
vim.api.nvim_command([[set runtimepath=$VIMRUNTIME]])
vim.api.nvim_command([[set packpath=/tmp/nvim/site]])

local package_root = "/tmp/nvim/site/pack"
local install_path = package_root .. "/packer/start/packer.nvim"

local function load_plugins()
  require("packer").startup({
    {
      "wbthomason/packer.nvim",
      -- ADD PLUGINS TO INSTALL
    },
    config = {
      package_root = package_root,
      compile_path = install_path .. "/plugin/packer_compiled.lua",
      display = { non_interactive = true },
    },
  })
end

_G.load_config = function()
  -- ADD INIT.LUA SETTINGS HERE LIKE LOADING OR CONFIGURING A PLUGIN
end

if vim.fn.isdirectory(install_path) == 0 then
  print("Installing Noice and dependencies.")
  vim.fn.system({ "git", "clone", "--depth=1", "https://github.com/wbthomason/packer.nvim", install_path })
end

load_plugins()
require("packer").sync()
vim.api.nvim_command([[autocmd User PackerComplete ++once echo "Ready!" | lua load_config()]])

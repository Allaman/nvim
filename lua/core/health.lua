local M = {}

local utils = require("utils.functions")
local plugins = vim.g.config.plugins
local tex = vim.g.config.plugins.tex

local health = vim.health
local _ok = health.ok
local _warn = health.warn
local _error = health.error

local programs = {
  go = {
    required = false,
    desc = "some Go related features might not work",
  },
  node = {
    required = false,
    desc = "Mason will not be able to install some LSPs/tools",
  },
  cargo = {
    required = false,
    desc = "some Rust related features might not work and tools that are built by cargo cannot be installed",
  },
  trash = {
    required = true,
    desc = "Neo-tree requires 'trash-cli' to be able to move files to the trash",
  },
  rg = {
    required = true,
    desc = "a highly recommended grep alternative (ripgrep is the package name)",
  },
  fd = {
    required = true,
    desc = "a highly recommended find alternative",
  },
}

local exec_not_found_template = "'%s' executable not found - %s"
local exec_found_template = "'%s' executable found"

M.check = function()
  vim.health.start("System configuration")
  local os = utils.getOS()

  if not utils.isNeovimVersionsatisfied(10) then
    _warn("This config probably won't work very well with Neovim < 0.10")
  else
    _ok("This config will work with your Neovim version")
  end

  if os == "NixOS" then
    _warn("This config downloads and runs binaries which might cause an issue on NixOS")
  elseif os == "" then
    _warn("Could not determine OS; Only Linux, Darwin, and NixOS is supported; It might work though")
  else
    _ok("Running on supported OS: " .. os)
  end

  if next(utils.load_user_config()) == nil then
    _warn("No or wrong (check :messages) user configuration provided (this is optional)")
  else
    _ok("User configuration found")
  end

  for k, v in pairs(programs) do
    if not utils.isExecutableAvailable(k) then
      if v.required then
        _error(string.format(exec_not_found_template, k, v.desc))
      else
        _warn(string.format(exec_not_found_template, k, v.desc))
      end
    else
      _ok(string.format(exec_found_template, k))
    end
  end

  if not utils.isExecutableAvailable(tex.vimtex_compiler_method) then
    _warn(string.format(exec_not_found_template, tex.vimtex_compiler_method, "to compile LaTex files"))
  else
    _ok(string.format(exec_found_template, tex.vimtex_compiler_method))
  end

  if not utils.isExecutableAvailable(tex.vimtex_view_method) then
    _warn(string.format(exec_not_found_template, tex.vimtex_view_method, "to view compiled LaTex files (PDFs)"))
  else
    _ok(string.format(exec_found_template, tex.vimtex_view_method))
  end

  if not utils.isExecutableAvailable("python") then
    if not utils.isExecutableAvailable("python3") then
      _warn("Python was not found - some Python related features might not work")
    end
  end

  if plugins.spectre.enable then
    if os == "Darwin" then
      if not utils.isExecutableAvailable("gsed") then
        _warn("gsed was not found - nvim-spectre (search and replace) might not work")
      else
        _ok(string.format(exec_found_template, "gsed"))
      end
    else
      if not utils.isExecutableAvailable("sed") then
        _warn("sed was not found - nvim-spectre (search and replace) might not work")
      else
        _ok(string.format(exec_found_template, "sed"))
      end
    end
  end
end

return M

-- Based on https://github.com/folke/lazy.nvim, using Neovim's built-in package manager (:h vim.pack)
-- DO NOT change the paths and don't remove the colorscheme
--
-- Start from a scratch directory with the XDG vars set in the shell, otherwise
-- your real config's plugin/ scripts are still on the rtp and get sourced.
-- ./repro.sh does this for you:
--   XDG_CONFIG_HOME=$PWD/.repro/config XDG_DATA_HOME=$PWD/.repro/data \
--   XDG_STATE_HOME=$PWD/.repro/state XDG_CACHE_HOME=$PWD/.repro/cache \
--   nvim -u minimal_init_pack.lua
local root = vim.fn.fnamemodify("./.repro", ":p")

-- set stdpaths to use .repro
for _, name in ipairs({ "config", "data", "state", "cache" }) do
  vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

-- 'packpath' is computed at startup, before this file runs, so point it at
-- .repro as well or vim.pack.add() can't find what it just installed
vim.opt.packpath:prepend(root .. "/data/nvim/site")

-- install plugins
vim.pack.add({
  { src = "https://github.com/folke/tokyonight.nvim" },
  -- add any other plugins here
})

vim.cmd.colorscheme("tokyonight")
-- add anything else here

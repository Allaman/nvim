local reload = require('nvim-reload')

-- If you use Neovim's built-in plugin system
-- Or a plugin manager that uses it (eg: packer.nvim)
local plugin_dirs = vim.fn.stdpath('data') .. '/site/pack/*/start/*'

reload.modules_reload_external = { 'packer' }

local map = vim.api.nvim_set_keymap
map('n', '<Leader>r', '<cmd>Reload<cr>', options)

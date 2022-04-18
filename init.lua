-- References to ./lua/
-- Plugin management via Packer
require("plugins")
-- Vim mappings, see lua/config/which.lua for more mappings
require("mappings")
-- All non plugin related (vim) options
require("options")
-- Vim autocommands/autogroups
require("autocmd")

-- enable filetypee.lua
-- This feature is currently opt-in
-- as it does not yet completely match all of the filetypes covered by filetype.vim
vim.g.do_filetype_lua = 1
-- disable filetype.vim
vim.g.did_load_filetypes = 0

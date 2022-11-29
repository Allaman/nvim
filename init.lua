-- References to ./lua/

-- Load global functions
require("anvim.globals")
-- Plugin management via Packer
require("anvim.plugins")
-- "Global" Keymappings
require("anvim.mappings")
-- All non plugin related (vim) options
require("anvim.options")
-- Vim autocommands/autogroups
require("anvim.autocmd")

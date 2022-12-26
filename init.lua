-- References to ./lua/

-- Load global functions
require("core.globals")
-- Plugin management via lazy
require("core.lazy")
-- Plugin management via Packer
-- require("core.packer")
-- "Global" Keymappings
require("core.mappings")
-- All non plugin related (vim) options
require("core.options")
-- Vim autocommands/autogroups
require("core.autocmd")

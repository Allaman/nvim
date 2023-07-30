-- References to ./lua/

-- Load global functions
require("core.globals")
-- configuration management
require("core.config").init()
-- Plugin management via lazy
require("core.lazy")
-- "Global" Keymappings
require("core.mappings")
-- Vim autocommands/autogroups
require("core.autocmd")

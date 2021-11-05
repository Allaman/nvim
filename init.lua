-- Plugin management via Packer
require("plugins")
-- Central file for keyboard mappings
require("mappings")
-- All non plugin related (vim) options
require("options")
-- Vim autocommands/autogroups
require("autocmd")
-- Cache packer_compiled via impatient.nvim
require("packer_compiled")
-- Enable LuaCacheProfile
require"impatient".enable_profile()

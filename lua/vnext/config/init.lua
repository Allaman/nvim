require("vnext.config.options")
require("vnext.config.lazy")
require("vnext.config.autocmds")
require("vnext.config.mappings")

-- HACK: the default color scheme has a very bright color
vim.api.nvim_set_hl(0, "StatusLine", { bg = "#1c1c1c" })

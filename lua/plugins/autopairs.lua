enable_check_bracket_line = false
local status_ok = pcall(require, "nvim-autopairs")
if not status_ok then
    return
end
local npairs = require "nvim-autopairs"

npairs.setup {
    check_ts = true,
    ts_config = {
        lua = {"string"}, -- it will not add pair on that treesitter node
        javascript = {"template_string"},
        java = false -- don't check treesitter on java
    }
}

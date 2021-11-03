require("doom-one").setup({
    cursor_coloring = false,
    terminal_colors = false,
    italic_comments = false,
    enable_treesitter = true,
    transparent_background = false,
    pumblend = {enable = true, transparency_amount = 20},
    plugins_integrations = {
        neorg = false,
        barbar = false,
        bufferline = true,
        gitgutter = false,
        gitsigns = true,
        telescope = true,
        neogit = true,
        nvim_tree = true,
        dashboard = true,
        startify = true,
        whichkey = true,
        indent_blankline = true,
        vim_illuminate = true,
        lspsaga = false
    }
})
-- Fix missing HOP highlight
vim.cmd("hi HopNextKey guifg=#009999")
vim.cmd("hi HopNextKey1 guifg=#009999")
vim.cmd("hi HopNextKey2 guifg=#009999")

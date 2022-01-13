require("doom-one").setup({
    cursor_coloring = true,
    terminal_colors = true,
    italic_comments = true,
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
        dashboard = false,
        startify = false,
        whichkey = true,
        indent_blankline = true,
        vim_illuminate = true,
        lspsaga = false
    }
})

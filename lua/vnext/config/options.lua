local o = vim.opt

vim.g.autoformat = true -- global var for toggling autoformat

-- stylua: ignore start
o.clipboard      = "unnamedplus"                                   -- keep in sync with the system clipboard
o.cursorline     = true                                            -- highlight the current line
o.dir            = vim.fn.stdpath("data") .. "/swp"                -- swap file directory
o.expandtab      = true                                            -- use spaces instead of tabs
o.fillchars      = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:" -- hide ~ at the end of buffer and set fold symbols
o.ignorecase     = true                                            -- ignore case in search patterns
o.mouse          = "nv"                                            -- enable mouse see :h mouse
o.relativenumber = true                                            -- set relative numbered lines
o.scrolloff      = 10                                              -- Minimal number of screen lines to keep above and below the cursor
o.signcolumn     = "yes"                                           -- Always show the signcolumn, otherwise it would shift the text each time
o.shiftwidth     = 2                                               -- the number of spaces inserted for each indentation
o.smartcase      = true                                            -- Don't ignore case with capitals
o.smartindent    = true                                            -- Insert indents automatically
o.splitbelow     = true                                            -- force all horizontal splits to go below current window
o.splitright     = true                                            -- force all vertical splits to go to the right of current window
o.tabstop        = 2                                               -- Number of spaces tabs count for
o.tabstop        = 2                                               -- how many columns a tab counts for
o.timeoutlen     = 300                                             -- time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen    = 0                                               -- Time in milliseconds to wait for a key code sequence to complete
o.undodir        = vim.fn.stdpath("data") .. "/undodir"            -- set undo directory
o.undofile       = true                                            -- enable/disable undo file creation
o.undolevels     = 1000                                            -- number of changes that can be undone
o.updatetime     = 250                                             -- faster completion
-- stylua: ignore end

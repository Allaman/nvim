local fn = vim.fn

return {
  options = {
    backup = false, -- creates a backup file
    clipboard = "unnamedplus", -- keep in sync with the system clipboard
    completeopt = "menu,menuone,noselect", -- A comma separated list of options for Insert mode completion
    conceallevel = 0, -- so that `` is visible in markdown files
    confirm = true, -- confirm to save changes before exiting modified buffer
    cursorline = true, -- highlight the current line
    dir = fn.stdpath("data") .. "/swp", -- swap file directory
    expandtab = true, -- use spaces instead of tabs
    foldenable = true,
    foldexpr = "v:lua.vim.lsp.foldexpr()",
    foldlevel = 99,
    foldlevelstart = 99,
    foldmethod = "expr",
    formatoptions = "jcroqlnt", -- tcqj
    fillchars = "eob: ,fold: ,foldopen:,foldsep: ,foldclose:", -- hide ~ at the end of buffer and set fold symbols
    grepprg = "rg --vimgrep --smart-case --", -- use rg instead of grep
    hidden = true, -- Enable modified buffers in background
    history = 500, -- Use the 'history' option to set the number of lines from command mode that are remembered.
    ignorecase = true, -- ignore case in search patterns
    inccommand = "split",
    list = false, -- enable or disable listchars
    listchars = {
      eol = "↲",
      tab = "→ ",
      trail = "+",
      extends = ">",
      precedes = "<",
      space = "·",
      nbsp = "␣",
    },
    mouse = "nv", -- enable mouse see :h mouse
    number = true, -- set numbered lines
    pumblend = 10, -- Popup blend
    pumheight = 10, -- Maximum number of entries in a popup
    relativenumber = true, -- set relative numbered lines
    scrolloff = 5, -- Minimal number of screen lines to keep above and below the cursor
    sessionoptions = { "buffers", "curdir", "tabpages", "winsize" },
    shiftround = true, -- Round indent
    shiftwidth = 2, -- the number of spaces inserted for each indentation
    showmode = false, -- we don't need to see things like -- INSERT -- anymore
    showtabline = 1, -- always show tabs; 0 never, 1 only if at least two tab pages, 2 always
    sidescrolloff = 5, -- The minimal number of columns to scroll horizontally
    signcolumn = "yes", -- Always show the signcolumn, otherwise it would shift the text each time
    smartcase = true, -- Don't ignore case with capitals
    smartindent = true, -- Insert indents automatically
    spell = false,
    splitbelow = true, -- force all horizontal splits to go below current window
    splitright = true, -- force all vertical splits to go to the right of current window
    swapfile = true, -- enable/disable swap file creation
    tabstop = 2, -- how many columns a tab counts for
    timeoutlen = 400, -- time to wait for a mapped sequence to complete (in milliseconds)
    ttimeoutlen = 0, -- Time in milliseconds to wait for a key code sequence to complete
    undodir = fn.stdpath("data") .. "/undodir", -- set undo directory
    undofile = true, -- enable/disable undo file creation
    undolevels = 1000,
    updatetime = 300, -- faster completion
    wildignorecase = true, -- When set case is ignored when completing file names and directories
    wildmode = "full", -- Command-line completion mode
    winminwidth = 5, -- minimum window width
    wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
]],
  },
}

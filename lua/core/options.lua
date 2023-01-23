local settings = require("core.settings")
local utils = require("core.utils.functions")
local o = vim.opt
local fn = vim.fn

if not settings.disable_winbar then
  o.winbar = "%{%v:lua.require'core.utils.winbar'.get_winbar()%}"
end
if settings.global_statusline then
  o.laststatus = 3
else
  o.laststatus = 2
end

if utils.isNotEmpty(settings.grepprg) then
  o.grepprg = settings.grepprg
end

o.backup = false -- creates a backup file
o.clipboard = "unnamedplus" -- keep in sync with the system clipboard
o.completeopt = "menu,menuone,noselect" -- A comma separated list of options for Insert mode completion
o.conceallevel = 0 -- so that `` is visible in markdown files
o.confirm = true -- confirm to save changes before exiting modified buffer
o.cursorline = true -- highlight the current line
o.dir = fn.stdpath("data") .. "/swp" -- swap file directory
o.expandtab = true -- use spaces instead of tabs
o.formatoptions = "jcroqlnt" -- tcqj
o.hidden = true -- Enable modified buffers in background
o.history = 500 -- Use the 'history' option to set the number of lines from command mode that are remembered.
o.ignorecase = true -- ignore case in search patterns
o.inccommand = "nosplit" -- preview incremental substitute
o.list = settings.list
o.listchars = settings.listchars
o.mouse = settings.mouse
o.number = settings.number
o.pumblend = 10 -- Popup blend
o.pumheight = 10 -- Maximum number of entries in a popup
o.relativenumber = settings.relative_number
o.scrolloff = 3 -- Minimal number of screen lines to keep above and below the cursor
o.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
o.shiftround = true -- Round indent
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.shortmess = o.shortmess + "c" -- prevent "pattern not found" messages
o.showmode = false -- we don't need to see things like -- INSERT -- anymore
o.showtabline = settings.showtabline
o.sidescrolloff = 5 -- The minimal number of columns to scroll horizontally
o.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
o.smartcase = true -- Don't ignore case with capitals
o.smartindent = true -- Insert indents automatically
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.swapfile = true -- enable/disable swap file creation
o.tabstop = 2 -- how many columns a tab counts for
o.termguicolors = true -- set term gui true colors (most terminals support this)
o.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen = 0 -- Time in milliseconds to wait for a key code sequence to complete
o.undodir = fn.stdpath("data") .. "/undodir" -- set undo directory
o.undofile = true -- enable/disable undo file creation
o.undolevels = 1000
o.updatetime = 300 -- faster completion
o.wildignorecase = true -- When set case is ignored when completing file names and directories
o.wildmode = "longest:full,full" -- Command-line completion mode
o.winminwidth = 5 -- minimum window width
o.wildignore = [[
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
]]

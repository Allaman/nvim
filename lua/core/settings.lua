local M = {}

-- theme: nightfox, tokyonight, tundra, kanagawa, oxocarbon; default is catppuccin
-- refer to the themes settings file for different styles
M.theme = "catppuccin"
-- Toggle global status line
M.global_statusline = true
-- use rg instead of grep
M.grepprg = "rg --hidden --vimgrep --smart-case --"
-- set numbered lines
M.number = true
-- enable mouse see :h mouse
M.mouse = "nv"
-- set relative numbered lines
M.relative_number = true
-- always show tabs; 0 never, 1 only if at least two tab pages, 2 always
M.showtabline = 1
-- enable or disable listchars
M.list = false
-- which list chars to schow
M.listchars = "eol:¬,tab:>·,trail:~,extends:>,precedes:<"
-- Noice heavily changes the Neovim UI ...
M.enable_noice = true
-- Number of recent files shown in dashboard
-- 0 disables showing recent files
M.dashboard_recent_files = 5
-- disable the header of the dashboard
M.disable_dashboard_header = false
-- disable quick links of the dashboard
M.disable_dashboard_quick_links = false
-- which tool to use for handling git merge conflicts
-- choose between "git-conflict" and "diffview"
M.merge_conflict_tool = "git-conflict"
-- treesitter parsers to be installed
-- one of "all", "maintained" (parsers with maintainers), or a list of languages
M.treesitter_ensure_installed = {
  "bash",
  "cmake",
  "css",
  "dockerfile",
  "go",
  "hcl",
  "html",
  "java",
  "javascript",
  "json",
  "kotlin",
  "ledger",
  "lua",
  "markdown",
  "markdown_inline",
  "query",
  "python",
  "regex",
  "rust",
  "terraform",
  "toml",
  "vim",
  "yaml",
}

-- LSPs that should be installed by Mason-lspconfig
M.lsp_servers = {
  "bashls",
  "dockerls",
  "jsonls",
  "gopls",
  "ltex",
  "marksman",
  "nil_ls",
  "pyright",
  "lua_ls",
  "rust_analyzer",
  "tailwindcss",
  "terraformls",
  "texlab",
  "tsserver",
  "typst_lsp",
  "yamlls",
}

-- Tools that should be installed by Mason
M.tools = {
  -- Formatter
  "black",
  "prettier",
  "stylua",
  "shfmt",
  -- Linter
  "eslint_d",
  "shellcheck",
  "tflint",
  "yamllint",
  "ruff",
  -- DAP
  "debugpy",
  "codelldb",
}

-- enable greping in hidden files
M.telescope_grep_hidden = true

-- which patterns to ignore in file switcher
M.telescope_file_ignore_patterns = {
  "%.7z",
  "%.JPEG",
  "%.JPG",
  "%.MOV",
  "%.RAF",
  "%.burp",
  "%.bz2",
  "%.cache",
  "%.class",
  "%.dll",
  "%.docx",
  "%.dylib",
  "%.epub",
  "%.exe",
  "%.flac",
  "%.ico",
  "%.ipynb",
  "%.jar",
  "%.jpeg",
  "%.jpg",
  "%.lock",
  "%.mkv",
  "%.mov",
  "%.mp4",
  "%.otf",
  "%.pdb",
  "%.pdf",
  "%.png",
  "%.rar",
  "%.sqlite3",
  "%.svg",
  "%.tar",
  "%.tar.gz",
  "%.ttf",
  "%.webp",
  "%.zip",
  ".git/",
  ".gradle/",
  ".idea/",
  ".settings/",
  ".vale/",
  ".vscode/",
  "__pycache__/*",
  "build/",
  "env/",
  "gradle/",
  "node_modules/",
  "smalljre_*/*",
  "target/",
  "vendor/*",
}

return M

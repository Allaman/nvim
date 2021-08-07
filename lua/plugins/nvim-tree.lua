local map = vim.api.nvim_set_keymap
map('n', '<Leader>p', ':NvimTreeToggle<CR>', options)
map('n', '<Leader>pf', ':NvimTreeFindFile<CR>', options)

vim.g.nvim_tree_highlight_opened_files = true
vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
vim.g.nvim_tree_side = "left"
vim.g.nvim_tree_width = 30
vim.g.nvim_tree_ignore = { ".git", "node_modules", ".cache" }
vim.g.nvim_tree_auto_open = 0
vim.g.nvim_tree_auto_close = 1
vim.g.nvim_tree_quit_on_open = 0
vim.g.nvim_tree_follow = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_hide_dotfiles = 1
vim.g.nvim_tree_git_hl = 1
vim.g.nvim_tree_root_folder_modifier = ":t"
vim.g.nvim_tree_tab_open = 0
vim.g.nvim_tree_allow_resize = 1
vim.g.nvim_tree_lsp_diagnostics = 1

vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = "",
    staged = "S",
    unmerged = "",
    renamed = "➜",
    deleted = "",
    untracked = "U",
    ignored = "◌",
  },
  folder = {
    default = "",
    open = "",
    empty = "",
    empty_open = "",
    symlink = "",
  },
}

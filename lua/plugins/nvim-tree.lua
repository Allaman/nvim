local g = vim.g

g.nvim_tree_side = 'left' -- left by default
g.nvim_tree_width = 40 -- 30 by default, can be width_in_columns or 'width_in_percent%'
g.nvim_tree_ignore = { '.git', 'node_modules', '.cache' } -- empty by default
g.nvim_tree_gitignore = 1 -- 0 by default
g.nvim_tree_auto_open = 0 -- 0 by default, opens the tree when typing `vim $DIR` or `vim`
g.nvim_tree_auto_close = 1 -- 0 by default, closes the tree when it's the last window
g.nvim_tree_auto_ignore_ft = {} -- empty by default, don't auto open tree on specific filetypes.
g.nvim_tree_quit_on_open = 0 -- 0 by default, closes the tree when you open a file
g.nvim_tree_follow = 1 -- 0 by default, this option allows the cursor to be updated when entering a buffer
g.nvim_tree_indent_markers = 1 -- 0 by default, this option shows indent markers when folders are open
g.nvim_tree_hide_dotfiles = 1 -- 0 by default, this option hides files and folders starting with a dot `.`
g.nvim_tree_git_hl = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 1 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
g.nvim_tree_root_folder_modifier = ':~' -- This is the default. See :help filename-modifiers for more options
g.nvim_tree_tab_open = 0 -- 0 by default, will open the tree when entering a new tab and the tree was previously open
g.nvim_tree_auto_resize = 0 -- 1 by default, will resize the tree to its saved width when opening a file
g.nvim_tree_disable_netrw = 1 -- 1 by default, disables netrw
g.nvim_tree_hijack_netrw = 1 -- 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
g.nvim_tree_add_trailing = 1 -- 0 by default, append a trailing slash to folder names
g.nvim_tree_group_empty = 1 --  0 by default, compact folders that only contain a single folder into one node in the file tree
g.nvim_tree_lsp_diagnostics = 1 -- 0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
g.nvim_tree_disable_window_picker = 1 -- 0 by default, will disable the window picker.
g.nvim_tree_hijack_cursor = 0 -- 1 by default, when moving cursor in the tree, will position the cursor at the start of the file on the current line
g.nvim_tree_icon_padding = ' ' -- one space by default, used for rendering the space between the icon and the filename. Use with caution, it could break rendering if you set an empty string depending on your font.
g.nvim_tree_symlink_arrow = ' >> ' --  defaults to ' ➛ '. used as a separator between symlinks' source and target.
g.nvim_tree_update_cwd = 1 -- 0 by default, will update the tree cwd when changing nvim's directory (DirChanged event). Behaves strangely with autochdir set.
g.nvim_tree_respect_buf_cwd = 1 -- 0 by default, will change cwd of nvim-tree to that of new buffer's when opening nvim-tree.

g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 1,
  folder_arrows = 1,
}
g.nvim_tree_icons = {
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


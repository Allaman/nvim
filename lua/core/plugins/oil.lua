local M = {
  "stevearc/oil.nvim",
  config = function()
    vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
    require("oil").setup({
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      keymaps = {
        ["g?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-v>"] = "actions.select_vsplit",
        ["<C-h>"] = "actions.select_split",
        ["<C-p>"] = "actions.preview",
        ["<C-l>"] = "actions.refresh",
        ["q"] = "actions.close",
        ["-"] = "actions.parent",
        ["_"] = "actions.open_cwd",
        ["<C-c>"] = "actions.cd",
        ["~"] = "actions.open_terminal",
        ["."] = "actions.toggle_hidden",
      },
    })
  end,
}

return M

local M = {
  "stevearc/oil.nvim",
}

function M.config()
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
      ["q"] = "actions.close",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["<C-c>"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["."] = "actions.toggle_hidden",
    },
  })
  vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
end

return M

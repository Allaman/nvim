local gh = require("config.util").gh

vim.pack.add({
  {
    src = gh("mikavilpas/yazi.nvim"),
    version = vim.version.range("*"),
  },
  {
    src = gh("nvim-lua/plenary.nvim"),
  },
})

local configured = false

local function get_yazi()
  local yazi = require("yazi")

  if not configured then
    yazi.setup({
      keymaps = {
        show_help = "g?",
      },
    })

    configured = true
  end

  return yazi
end

vim.keymap.set("n", "<leader>lf", function()
  get_yazi().yazi()
end, {
  desc = "Open Yazi (file manager)",
})

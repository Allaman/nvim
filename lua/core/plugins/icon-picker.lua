return {
  "ziontee113/icon-picker.nvim",
  dependencies = "stevearc/dressing.nvim",
  config = function()
    require("icon-picker").setup({
      disable_legacy_commands = true,
    })
  end,
}

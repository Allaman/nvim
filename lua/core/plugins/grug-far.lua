local user_config = vim.g.config.plugins.grug_far or {}

local default_config = {
  enabled = false,
  opts = {},
  keys = {
    -- stylua: ignore start
    { "<leader>R", "", desc = "Search & Replace" },
    { "<leader>RG", "<cmd>GrugFar<cr>", desc = "Open" },
    { "<leader>Rg", "<cmd>lua require('grug-far').open({ prefills = { paths = vim.fn.expand('%') } })<cr>", desc = "Open (Limit to current file)"},
    { "<leader>Rw", "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })<cr>", desc = "Search word under cursor", },
    { "<leader>Rs", mode = "v", "<cmd>lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand('%') } })<cr>", desc = "Search selection", },
    -- stylua: ignore end
  },
  cmd = "GrugFar",
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  enabled = config.enabled,
  "MagicDuck/grug-far.nvim",
  cmd = config.cmd,
  opts = config.opts,
  keys = config.keys,
}

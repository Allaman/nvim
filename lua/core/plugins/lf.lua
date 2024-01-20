local config = vim.g.config.plugins.lf
return {
  "lmburns/lf.nvim",
  enabled = config.enable,
  dependencies = "akinsho/nvim-toggleterm.lua",
  opts = {
    border = "rounded",
    -- TODO: my mapping <leader>lf is soo good but in the LSP cluster
    config.key_mappings(),
    vim.api.nvim_create_autocmd("User", {
      pattern = "LfTermEnter",
      callback = function(a)
        vim.api.nvim_buf_set_keymap(a.buf, "t", "q", "q", { nowait = true })
      end,
    }),
  },
  config = function(opts)
    -- does not work when lazy loaded
    vim.g.lf_netrw = 1
    require("lf").setup(opts)
  end,
}

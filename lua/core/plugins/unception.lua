return {
  "samjwill/nvim-unception",
  init = function()
    unception_delete_replaced_buffer = true
    -- Optional settings go here!
  end,
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "UnceptionEditRequestReceived",
      callback = function()
        -- Toggle the terminal off.
        vim.cmd(":ToggleTerm")
      end,
    })
  end,
}

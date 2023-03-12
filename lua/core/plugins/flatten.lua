return {
  "willothy/flatten.nvim",
  opts = {
    window = {
      open = "current",
    },
    callbacks = {
      pre_open = function()
        -- Close toggleterm when an external open request is received
        require("toggleterm").toggle(0)
      end,
      post_open = function(bufnr, winnr, ft)
        if ft == "gitcommit" then
          -- If the file is a git commit, create one-shot autocmd to delete it on write
          -- If you just want the toggleable terminal integration, ignore this bit and only use the
          -- code in the else block
          vim.api.nvim_create_autocmd("BufWritePost", {
            buffer = bufnr,
            once = true,
            callback = function()
              -- This is a bit of a hack, but if you run bufdelete immediately
              -- the shell can occasionally freeze
              vim.defer_fn(function()
                vim.api.nvim_buf_delete(bufnr, {})
              end, 50)
            end,
          })
        else
          -- If it's a normal file, then reopen the terminal, then switch back to the newly opened window
          -- This gives the appearance of the window opening independently of the terminal
          require("toggleterm").toggle(0)
          vim.api.nvim_set_current_win(winnr)
        end
      end,
      block_end = function()
        -- After blocking ends (for a git commit, etc), reopen the terminal
        require("toggleterm").toggle(0)
      end,
    },
  },
}

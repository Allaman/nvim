local api = vim.api

api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.hl.hl_op()
  end,
  desc = "highlight on yank",
})

api.nvim_create_autocmd("BufEnter", {
  callback = function()
    vim.opt.formatoptions:remove({ "c", "r", "o" })
  end,
  desc = "Disable New Line Comment",
})

api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = api.nvim_buf_get_mark(0, '"')
    local lcount = api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
  desc = "go to last position when opening a buffer",
})

api.nvim_create_autocmd("FileType", {
  pattern = {
    "grug-far",
    "help",
    "nvim-pack",
    "qf",
    "query",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
  end,
  desc = "close certain windows with q",
})

api.nvim_create_autocmd("FileType", {
  pattern = {
    "man",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "ZQ", { buffer = event.buf, silent = true })
  end,
  desc = "quit man page Neovim",
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*Dockerfile*",
  callback = function()
    vim.bo.filetype = "dockerfile"
  end,
})

vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function(ev)
    if vim.bo[ev.buf].filetype == "snacks_dashboard" then
      return
    end
    vim.schedule(function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        if vim.api.nvim_win_is_valid(win) then
          local wbuf = vim.api.nvim_win_get_buf(win)
          if vim.bo[wbuf].filetype == "snacks_dashboard" then
            pcall(vim.api.nvim_win_close, win, true)
          end
        end
      end
    end)
  end,
})

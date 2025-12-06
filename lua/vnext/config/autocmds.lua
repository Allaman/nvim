local api = vim.api

api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
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
  desc = "go to last loc when opening a buffer",
})

api.nvim_create_autocmd("FileType", {
  pattern = {
    "grug-far",
    "help",
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

local chezmoi_path = vim.fn.resolve(vim.fn.expand("~/.local/share/chezmoi"))
api.nvim_create_autocmd("BufWritePost", {
  pattern = {
    chezmoi_path .. "/**/*", -- files in subdirectories
  },
  callback = function()
    vim.notify("Applying chezmoi changes", vim.log.levels.INFO)
    vim.system({ "chezmoi", "apply", "-k" })
  end,
})

api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*Dockerfile*",
  callback = function()
    vim.bo.filetype = "dockerfile"
  end,
})

vim.api.nvim_create_user_command("IPCalc", function(opts)
  local word

  -- Check if called from visual mode
  if opts.range > 0 then
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local lines = vim.fn.getline(start_pos[2], end_pos[2])

    -- Handle single line selection
    if #lines == 1 then
      lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
    else
      -- Multi-line selection (take first line for now)
      lines[1] = string.sub(lines[1], start_pos[3])
    end

    word = lines[1]
  else
    -- Get the WORD under the cursor (includes special chars like /)
    word = vim.fn.expand("<cWORD>")
  end

  -- Check if the word looks like an IP address with optional CIDR notation
  -- Matches: 192.168.1.1 or 192.168.1.0/24
  if not word:match("^%d+%.%d+%.%d+%.%d+/?%d*$") then
    vim.notify("No valid IP address under cursor or selected", vim.log.levels.WARN)
    return
  end

  local output = vim.fn.system("ipcalc " .. vim.fn.shellescape(word))

  if vim.v.shell_error ~= 0 then
    vim.notify("ipcalc command failed", vim.log.levels.ERROR)
    return
  end

  -- Display output in a floating window
  local lines = vim.split(output, "\n")
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local width = 80
  local height = 10
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  -- Open floating window
  vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    style = "minimal",
    border = "rounded",
    title = " ipcalc: " .. word .. " ",
    title_pos = "center",
  })

  vim.bo[buf].modifiable = false
  vim.bo[buf].buftype = "nofile"

  vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", { nowait = true })
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", ":close<CR>", { nowait = true })
end, {
  range = true, -- Enable range support
  desc = "Run ipcalc on IP address under cursor or visual selection",
})

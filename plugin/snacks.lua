local gh = require("config.util").gh

vim.pack.add({ gh("folke/snacks.nvim") })

local Snacks = require("snacks")

Snacks.setup({
  bigfile = {
    enabled = true,
    size = 0.5 * 1024 * 1024, -- 0.5MB
  },

  dashboard = {
    enabled = true,
    preset = {
      ---@type snacks.dashboard.Item[]
      -- stylua: ignore start
      keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.files({ filter = { cwd = true }, layout = 'default' })" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "s", desc = "Find Text", action = ":lua Snacks.picker.grep({ layout = 'default' })" },
        { icon = " ", key = "b", desc = "File browser", action = function() require("yazi").yazi(nil, vim.fn.getcwd()) end },
        { icon = " ", key = "g", desc = "Git", action = ":G" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        -- stylua: ignore end
      },
    },

    sections = {
      -- { section = "header" },

      {
        section = "keys",
        icon = " ",
        padding = 1,
      },

      {
        section = "recent_files",
        cwd = true,
        filter = function(file)
          -- Filter out paths I don't want in recent files
          return vim.fn.isdirectory(file) == 0 and not (file:match("^/tmp/") or file:match("%.git/"))
        end,
        icon = " ",
        title = "Recent Files",
        padding = 1,
      },

      {
        icon = " ",
        title = "Git Status",
        section = "terminal",
        enabled = function()
          return Snacks.git.get_root() ~= nil
        end,
        cmd = "git status --short --branch --renames",
        height = 5,
        padding = 1,
        ttl = 5 * 60,
      },
    },
  },

  dim = {
    enabled = true,
  },

  explorer = {
    enabled = true,
    replace_netrw = true,
  },

  -- gh = {}, -- just to keep in mind that this exists :)

  indent = {
    enabled = true,
    indent = {
      only_scope = true,
    },
    chunk = {
      enabled = true,
    },
    animate = {
      enabled = false,
    },
  },

  image = {
    enabled = true,
    doc = {
      -- don't render images in e.g. markdown
      enabled = false,
    },
  },

  input = {
    enabled = true,
  },

  notifier = {
    enabled = true,
    timeout = 2000,
  },

  gitbrowse = {
    remote_patterns = {
      { "^git@treetop.com:v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
      { "^(https?://.*)%.git$", "%1" },
      { "^git@(.+):(.+)%.git$", "https://%1/%2" },
      { "^git@(.+):(.+)$", "https://%1/%2" },
      { "^git@(.+)/(.+)$", "https://%1/%2" },
      { "^org%-%d+@(.+):(.+)%.git$", "https://%1/%2" },
      { "^ssh://git@(.*)$", "https://%1" },
      { "^ssh://([^:/]+)(:%d+)/(.*)$", "https://%1/%3" },
      { "^ssh://([^/]+)/(.*)$", "https://%1/%2" },
      { "ssh%.dev%.azure%.com/v3/(.*)/(.*)$", "dev.azure.com/%1/_git/%2" },
      { "^https://%w*@(.*)", "https://%1" },
      { "^git@(.*)", "https://%1" },
      { ":%d+", "" },
      { "%.git$", "" },
    },

    url_patterns = {
      ["dev%.azure%.com"] = {
        file = "?path=/{file}&version=GB{branch}&line={line_start}&lineEnd={line_end}&lineStartColumn=1&lineEndColumn=1&lineStyle=plain&_a=contents",
        commit = "/commit/{commit}",
        branch = "",
      },
    },
  },

  picker = {
    layout = "ivy",

    win = {
      input = {
        keys = {
          -- TODO: not sure if how I want this
          ["<Esc>"] = { "close", mode = { "n", "i" } },
          ["<C-h>"] = { "toggle_hidden", mode = { "i", "n" } },
          ["<C-l>"] = { "toggle_ignored", mode = { "i", "n" } },
          ["<C-r>"] = { "toggle_regex", mode = { "i", "n" } },
          ["<C-p>"] = { "toggle_preview", mode = { "i", "n" } },
        },
      },
    },
  },

  quickfile = {
    enabled = true,
  },

  statuscolumn = {
    enabled = true,
  },

  words = {
    enabled = true,
  },

  zen = {
    enabled = true,
  },

  styles = {
    notification = {
      wo = {
        wrap = true,
      },
    },
  },
})

-- Keymaps

local function map(mode, lhs, rhs, opts)
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- stylua: ignore start
map("n", "<leader>uZ", function() Snacks.zen() end, { desc = "Toggle Zen Mode" })
map("n", "<leader>uz", function() Snacks.zen.zoom() end, { desc = "Toggle Zoom" })

-- map("n", "<leader>nd", function() Snacks.notifier.hide() end, { desc = "Dismiss All Notifications" })
-- map("n", "<leader>nN", function() Snacks.picker.notifications() end, { desc = "Notification History" })

map("n", "<leader>bd", function() Snacks.bufdelete() end, { desc = "Delete Buffer" })
map("n", "<leader>bD", function() Snacks.bufdelete.other() end, { desc = "Close all but the current buffer" })

map("n", "<leader>gB", function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })

map({ "n", "v" }, "<leader>go", function()
  Snacks.gitbrowse()
end, { desc = "Open git link" })

map({ "n", "v" }, "<leader>gc", function()
  Snacks.gitbrowse({
    open = function(url)
      vim.fn.setreg("+", url)
    end,
    notify = false,
  })
end, { desc = "Copy git link" })

map("n", "<leader>sb", function() Snacks.picker.git_branches() end, { desc = "Branches" })
map("n", "<leader>su", function() Snacks.picker.undo() end, { desc = "Undo Tree" })

map("n", "<leader>fR", function()
  Snacks.rename.rename_file()
end, { desc = "Rename File" })

map("n", "*", function()
  Snacks.words.jump(vim.v.count1)
end, { desc = "Next Reference" })

map("n", "#", function()
  Snacks.words.jump(-vim.v.count1)
end, { desc = "Prev Reference" })

map("n", "<leader>ss", function() Snacks.picker.grep() end, { desc = "Strings" })
map("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "Help" })

map("n", "<leader>ff", function()
  Snacks.picker.files({
    filter = {
      cwd = true,
    },
  })
end, { desc = "Find" })

map("n", "<leader>fr", function()
  Snacks.picker.recent({
    filter = {
      cwd = true,
    },
  })
end, { desc = "Recent" })

map("n", "<leader>fg", function() Snacks.picker.git_status() end, { desc = "Git" })
map("n", "<leader>bb", function() Snacks.picker.buffers() end, { desc = "Buffers" })
map("n", "<leader>sl", function() Snacks.picker.lines() end, { desc = "Buffer Lines" })
map("n", "<leader>si", function() Snacks.picker.icons() end, { desc = "Icons" })

map("n", "<leader>ls", function() Snacks.picker.lsp_symbols() end, { desc = "Documents Symbols" })
map("n", "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "Workspace Symbols" })

map("n", "<leader>sz", function() Snacks.picker.zoxide() end, { desc = "Zoxide" })

map({ "n", "x" }, "<leader>sw", function()
  Snacks.picker.grep_word()
end, { desc = "Visual selection or word" })

map("n", "<leader>sD", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })
map("n", "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, { desc = "Buffer Diagnostics" })
map("n", "<leader>sk", function() Snacks.picker.keymaps() end, { desc = "Keymaps" })

map("n", "<leader>ld", function() Snacks.picker.lsp_definitions() end, { desc = "Definition" })

map("n", "<leader>lr", function()
  Snacks.picker.lsp_references()
end, {
  desc = "References",
  nowait = true,
})

map("n", "<leader>lI", function() Snacks.picker.lsp_implementations() end, { desc = "Implementation" })
map("n", "<leader>lt", function() Snacks.picker.lsp_type_definitions() end, { desc = "Type Definition" })

map("n", "<leader>sR", function() Snacks.picker.resume() end, { desc = "Resume" })

map("n", "<C-n>", function()
  Snacks.terminal()
end, { desc = "Toggle Terminal" })
-- stylua: ignore end

map("n", "<leader>fp", function()
  -- Find explorer: a non-floating snacks_picker_list window
  local exp_win

  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)

    if vim.bo[buf].filetype == "snacks_picker_list" and vim.api.nvim_win_get_config(win).relative == "" then
      exp_win = win
      break
    end
  end

  if exp_win then
    if vim.api.nvim_get_current_win() == exp_win then
      vim.api.nvim_win_close(exp_win, false)
    else
      vim.api.nvim_set_current_win(exp_win)
    end
  else
    Snacks.explorer()
  end
end, { desc = "Toggle Explorer" })

-- Toggles
--
-- lazy.nvim's `VeryLazy` event was only being used to defer these.
-- Since Snacks is eagerly set up above, they can be registered directly.

-- stylua: ignore start
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>un")
Snacks.toggle.option("cursorline", { name = "Cursorline" }):map("<leader>uC")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle.option("conceallevel", {
  off = 0,
  on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2,
}):map("<leader>uc")
Snacks.toggle.inlay_hints():map("<leader>uh")
Snacks.toggle.dim():map("<leader>uD")
-- stylua: ignore end

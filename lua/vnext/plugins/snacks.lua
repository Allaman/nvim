-- TODO: profiler

---@module 'snacks'

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        ---@type snacks.dashboard.Item[]
        -- stylua: ignore start
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.picker.smart({filter = {cwd = true}, layout = 'default'})" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "s", desc = "Find Text", action = ":lua Snacks.picker.grep({layout = 'default'})" },
          { icon = " ", key = "b", desc = "File browser", action = function()  require("yazi").yazi(nil, vim.fn.getcwd()) end,
          },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy check", enabled = package.loaded.lazy },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          -- stylua: ignore end
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1 },
        { title = "Recent Files", section = "recent_files", cwd = true, indent = 2, padding = { 2, 2 } },
        { section = "startup" },
      },
    },
    dim = { enabled = true },
    image = {},
    indent = {
      enabled = true,
      indent = { only_scope = true }, -- only show indent where cursor is
      chunk = { enabled = true }, -- indents are rendered as chunks
      animate = { enabled = false }, -- do not animate -- feels slow for me
    },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 2000,
    },
    picker = {
      layout = "ivy",
      win = {
        input = {
          keys = {
            -- TODO: not sure if I want this as before
            -- ["<Esc>"] = { "close", mode = { "n", "i" } },
            ["<C-h>"] = { "toggle_hidden", mode = { "i", "n" } },
          },
        },
      },
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true },
      },
    },
  },
  keys = {
    -- stylua: ignore start
    { "<leader>uZ",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>uz",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
    -- { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>gB", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gx", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>sb", function() Snacks.picker.git_branches() end, desc = "Branches" },
    { "<leader>su", function() Snacks.picker.undo() end, desc = "Undo Tree" },
    { "<leader>fR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
    { "*",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
    { "#",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
    { "<leader>ss", function() Snacks.picker.grep() end, desc = "Strings" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Help" },
    { "<leader>ff", function() Snacks.picker.smart({filter = {cwd = true}}) end, desc = "Smart find" },
    { "<leader>sl", function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>si", function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>sL", function() Snacks.picker.lazy() end, desc = "LazySpec" },
    { "<leader>ls", function() Snacks.picker.lsp_symbols() end, desc = "Documents Symbols" },
    { "<leader>lS", function() Snacks.picker.lsp_workspace_symbols() end, desc = "Workspace Symbols" },
    { "<leader>sz", function() Snacks.picker.zoxide() end, desc = "Zoxide" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>gl", function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>sd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>ld", function() Snacks.picker.lsp_definitions() end, desc = "Definition" },
    { "<leader>lr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "<leader>lI", function() Snacks.picker.lsp_implementations() end, desc = "Implementation" },
    { "<leader>lt", function() Snacks.picker.lsp_type_definitions() end, desc = "Type Definition" },
  },
  -- stylua: ignore end
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- stylua: ignore start
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>un")
        Snacks.toggle.option("cursorline", { name = "Cursorline" }):map("<leader>uC")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.dim():map("<leader>uD")
        -- stylua: ignore end
      end,
    })
  end,
}

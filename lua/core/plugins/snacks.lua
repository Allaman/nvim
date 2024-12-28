local user_config = vim.g.config.plugins.snacks or {}

-- TODO: profiler
local default_config = {
  enabled = true,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        ---@type snacks.dashboard.Item[]
        -- stylua: ignore start
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "s", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "b", desc = "File browser", action = function() require("yazi").yazi(nil, vim.fn.getcwd()) end,
          },
          -- { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy check", enabled = package.loaded.lazy },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          -- stylua: ignore end
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", gap = 1 },
        { title = "Recent Files", section = "recent_files", indent = 2, padding = { 2, 2 } },
        { section = "startup" },
      },
    },
    dim = { enabled = true },
    indent = { enabled = true }, -- animation is on by default
    notifier = {
      enabled = true,
      timeout = 2000,
    },
    quickfile = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    zen = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
  keys = {
    -- stylua: ignore start
    { "<leader>mZ",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>mz",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
    { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>gL", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gB", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gx", function() Snacks.gitbrowse() end, desc = "Git Browse" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
    { "<leader>fR", function() Snacks.rename.rename_file() end, desc = "Rename File" },
    { "*",         function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference" },
    { "#",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference" },
    -- stylua: ignore end
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "folke/snacks.nvim",
  enabled = config.enabled,
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = config.opts,
  keys = config.keys,
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- stylua: ignore start
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>ts")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>tw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>tn")
        Snacks.toggle.option("cursorline", { name = "Cursorline" }):map("<leader>tC")
        Snacks.toggle.diagnostics():map("<leader>td")
        Snacks.toggle.line_number():map("<leader>tl")
        Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map("<leader>tc")
        Snacks.toggle.treesitter():map("<leader>mT")
        Snacks.toggle.inlay_hints():map("<leader>lh")
        Snacks.toggle.dim():map("<leader>tD")
        -- stylua: ignore end
      end,
    })
  end,
}

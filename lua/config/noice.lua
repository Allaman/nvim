require("noice").setup({
  cmdline = {
    view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
    opts = { buf_options = { filetype = "vim" } }, -- enable syntax highlighting in the cmdline
    icons = {
      ["/"] = { icon = " ", hl_group = "DiagnosticWarn" },
      ["?"] = { icon = " ", hl_group = "DiagnosticWarn" },
      [":"] = { icon = " ", hl_group = "DiagnosticInfo", firstc = false },
    },
  },
  popupmenu = {
    enabled = false, -- disable if you use something like cmp-cmdline
    ---@type 'nui'|'cmp'
    backend = "nui", -- backend to use to show regular cmdline completions
    -- You can specify options for nui under `config.views.popupmenu`
  },
  history = {
    -- options for the message history that you get with `:Noice`
    view = "split",
    opts = { enter = true },
    filter = { event = "msg_show", ["not"] = { kind = { "search_count", "echo" } } },
  },
  notify = {
    -- Noice can be used as `vim.notify` so you can route any notification like other messages
    -- Notification messages have their level and other properties set.
    -- event is always "notify" and kind can be any log level as a string
    -- The default routes will forward notifications to nvim-notify
    enabled = false,
  },
  throttle = 1000 / 30, -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
  -- @type table<string, NoiceViewOptions>
  views = {}, -- @see the section on views below
  -- @type NoiceRouteConfig[]
  routes = {}, -- @see the section on routes below
  -- @type table<string, NoiceFilter>
  status = {}, --@see the section on statusline components below
})

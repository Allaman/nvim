return {
  {
    "zbirenbaum/copilot.lua",
    -- requires = {
    --   "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
    -- },
    cmd = "Copilot",
    event = "InsertEnter",
    opts = {
      server_opts_overrides = {
        settings = {
          telemetry = {
            telemetryLevel = false,
          },
        },
      },
      suggestion = {
        enabled = false,
        -- auto_trigger = true,
      },
      panel = { enabled = false },
      keymap = {
        accept = "C-p",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
        toggle_auto_trigger = false,
      },
      filetypes = {
        python = true,
        go = true,
        lua = true,
        sh = true,
        terraform = true,
        ["*"] = false, -- disable for all other filetypes and ignore default `filetypes`
      },
    },
    config = function(_, opts)
      require("copilot").setup(opts)
    end,
  },
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = { "fang2hou/blink-copilot" },
    opts = {
      sources = {
        default = { "copilot" },
        providers = {
          copilot = {
            name = "copilot",
            module = "blink-copilot",
            score_offset = 100,
            async = true,
          },
        },
      },
    },
  },
}

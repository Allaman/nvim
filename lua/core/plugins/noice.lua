local user_config = vim.g.config.plugins.noice or {}

local default_config = {
  enabled = true,
  opts = {
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
      },
    },
    -- you can enable a preset for easier configuration
    presets = {
      bottom_search = false, -- use a classic bottom cmdline for search
      command_palette = true, -- position the cmdline and popupmenu together
      long_message_to_split = true, -- long messages will be sent to a split
      inc_rename = true, -- enables an input dialog for inc-rename.nvim
      lsp_doc_border = false, -- add a border to hover docs and signature help
    },
    routes = {
      { view = "notify", filter = { event = "msg_showmode" } }, -- show "recording macro"
      --   { filter = { event = "msg_show", find = "written" }, opts = { skip = true } }, -- skip "write" message on save
    },
  },
  keys = {
    { "<leader>n", "", desc = "Noice" },
    { "<leader>nd", "<cmd>Noice dismiss<cr>", desc = "Dismiss all visible messages" },
    { "<leader>nn", "<cmd>Noice<cr>", desc = "Open Noice" },
    { "<leader>ne", "<cmd>Noice errors<cr>", desc = "Open Noice Errors" },
    { "<leader>nt", "<cmd>Noice telescope<cr>", desc = "Open Noice with telescope" },
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  {
    "folke/noice.nvim",
    enabled = config.enabled,
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      {
        "rcarriga/nvim-notify",
        opts = {
          top_down = true,
        },
      },
    },
    keys = config.keys,
    opts = config.opts,
  },
}

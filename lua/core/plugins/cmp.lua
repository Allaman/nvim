local user_config = vim.g.config.plugins.cmp or {}

local default_config = {
  enabled = false,
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  "iguanacucumber/magazine.nvim",
  name = "nvim-cmp",
  enabled = config.enabled,
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-calc",
    "lukas-reineke/cmp-rg",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local cmp = require("cmp")
    local lspkind = require("lspkind")

    local sources = {
      { name = "nvim_lsp", priority = 500 },
      { name = "luasnip", priority = 1000 },
      { name = "calc", priority = 200 },
      { name = "path", priority = 300 },
      { name = "rg", keyword_length = 3, priority = 400 },
    }

    if vim.g.config.plugins.emoji.enable then
      table.insert(sources, { name = "emoji" })
    end

    local format = {
      mode = "symbol",
      max_width = 50,
      symbol_map = {
        Text = "󰉿",
        Method = "󰆧",
        Function = "󰊕",
        Constructor = "",
        Field = "󰜢",
        Variable = "󰀫",
        Class = "󰠱",
        Interface = "",
        Module = "",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "",
        Keyword = "󰌋",
        Snippet = "",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "",
        Supermaven = "",
      },
    }

    local icons = require("utils.icons")

    if vim.g.config.plugins.copilot.enable then
      table.insert(sources, { name = "copilot", group_index = 2 })
      table.insert(format.symbol_map, { Copilot = icons.apps.Copilot })
    end

    if vim.g.config.plugins.supermaven.enabled then
      table.insert(sources, { name = "supermaven" })
      format.symbol_map.Supermaven = icons.apps.Supermaven
    end

    local has_words_before = function()
      if vim.api.nvim_get_option_value("buftype", { buf = 0 }) == "prompt" then
        return false
      end
      local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
    end

    cmp.setup({
      formatting = {
        format = lspkind.cmp_format(format),
      },
      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
      preselect = cmp.PreselectMode.None,
      mapping = {
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-u>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_prev_item()
          end
        end, { "i", "s" }),
      },
      sources = sources,
    })
  end,
}

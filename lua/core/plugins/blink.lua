-- much was stolen from LazyVim :)
-- TODO: copilot and supermaven itegration
local user_config = vim.g.config.plugins.blink or {}

local default_config = {
  enabled = false,
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = { "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "fallback" },

      ["<S-Tab>"] = { "select_prev", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },

      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
    },

    sources = {
      compat = {},
      completion = {
        enabled_providers = { "lsp", "path", "luasnip", "buffer" },
      },
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 250,
      },
      menu = {
        draw = {
          -- nvim-cmp look
          -- columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind", gap = 1 } },
          columns = { { "label", "label_description", gap = 1 }, { "kind_icon" } },
        },
      },
    },
    -- experimental auto-brackets support
    -- completion = { accept = { auto_brackets = { enabled = true } } }

    -- experimental signature help support
    -- signature = { enabled = true }
  },
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  {
    "saghen/blink.cmp",
    event = "InsertEnter",
    enabled = config.enabled,
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        optional = true,
        opts = {},
      },
    },
    version = "v0.*",
    opts = config.opts,
    opts_extend = {
      "sources.completion.enabled_providers",
      "sources.compat",
    },
    config = function(_, opts)
      -- setup compat sources and provider
      local enabled = opts.sources.completion.enabled_providers
      for _, source in ipairs(opts.sources.compat or {}) do
        opts.sources.providers[source] = vim.tbl_deep_extend(
          "force",
          { name = source, module = "blink.compat.source" },
          opts.sources.providers[source] or {}
        )
        if type(enabled) == "table" and not vim.tbl_contains(enabled, source) then
          table.insert(enabled, source)
        end
      end

      -- check if we need to override symbol kinds
      for _, provider in pairs(opts.sources.providers or {}) do
        ---@cast provider blink.cmp.SourceProviderConfig|{kind?:string}
        if provider.kind then
          require("blink.cmp.types").CompletionItemKind[provider.kind] = provider.kind
          ---@type fun(ctx: blink.cmp.Context, items: blink.cmp.CompletionItem[]): blink.cmp.CompletionItem[]
          local transform_items = provider.transform_items
          ---@param ctx blink.cmp.Context
          ---@param items blink.cmp.CompletionItem[]
          provider.transform_items = function(ctx, items)
            items = transform_items and transform_items(ctx, items) or items
            for _, item in ipairs(items) do
              item.kind = provider.kind or item.kind
            end
            return items
          end
        end
      end

      require("blink.cmp").setup(opts)
    end,
  },

  -- lazydev integration
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        completion = {
          -- add lazydev to your completion providers
          enabled_providers = { "lazydev" },
        },
        providers = {
          lsp = {
            -- dont show LuaLS require statements when lazydev has items
            fallback_for = { "lazydev" },
          },
          lazydev = {
            name = "LazyDev",
            module = "lazydev.integrations.blink",
          },
        },
      },
    },
  },
  -- luasnip integration
  {
    "saghen/blink.cmp",
    optional = true,
    dependencies = {
      { "saghen/blink.compat" },
      { "saadparwaiz1/cmp_luasnip" },
    },
    opts = {
      sources = { compat = { "luasnip" } },
      snippets = {
        expand = function(snippet)
          require("luasnip").lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require("luasnip").jumpable(filter.direction)
          end
          return require("luasnip").in_snippet()
        end,
        jump = function(direction)
          require("luasnip").jump(direction)
        end,
      },
    },
  },
  -- catppuccin integration
  {
    "catppuccin",
    optional = true,
    opts = {
      integrations = { blink_cmp = true },
    },
  },
}

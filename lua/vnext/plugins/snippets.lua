return {
  {
    "L3MON4D3/LuaSnip",
    lazy = true,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load() -- load friendly-snippets
          require("luasnip").filetype_extend("all", { "loremipsum" }) -- load loremipsum snippets from friendly-snippets
        end,
      },
    },
    build = "make install_jsregexp",
    opts = {
      snippets_path = { vim.fn.stdpath("config") .. "/snippets" }, -- can be overwritten with a LazySpec in extra/
      history = true,
      updateevents = "TextChanged,TextChangedI",
      delete_check_events = "TextChanged",
    },
    config = function(_, opts)
      -- load VSC style snippets
      require("luasnip.loaders.from_vscode").lazy_load({ paths = opts.snippets_path })
      -- selecting within a list of snippet options.
      vim.keymap.set("i", "<c-h>", function()
        if require("luasnip").choice_active() then
          require("luasnip").change_choice(1)
        end
      end)
    end,
  },

  -- luasnip integration
  {
    "saghen/blink.cmp",
    opts = {
      snippets = {
        preset = "luasnip",
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
}

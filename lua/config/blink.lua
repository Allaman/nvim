local M = {}

M.opts = {
  fuzzy = {
    implementation = "prefer_rust_with_warning",
  },

  keymap = {
    ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
    ["<C-e>"] = { "hide", "fallback" },
    ["<CR>"] = { "accept", "fallback" },

    ["<Tab>"] = {
      function(cmp)
        return cmp.select_next()
      end,
      "snippet_forward",
      "fallback",
    },

    ["<S-Tab>"] = {
      function(cmp)
        return cmp.select_prev()
      end,
      "snippet_backward",
      "fallback",
    },

    ["<C-k>"] = { "select_prev", "fallback" },
    ["<C-j>"] = { "select_next", "fallback" },

    ["<C-f>"] = { "scroll_documentation_up", "fallback" },
    ["<C-b>"] = { "scroll_documentation_down", "fallback" },
  },

  sources = {
    default = {
      "lsp",
      "path",
      "snippets",
      "buffer",
    },

    per_filetype = {},

    providers = {
      lsp = {
        min_keyword_length = function(ctx)
          return ctx.trigger.kind == "manual" and 0 or 2
        end,
        score_offset = 0,
      },

      path = {
        min_keyword_length = 0,
      },

      snippets = {
        min_keyword_length = 2,
        should_show_items = function(ctx)
          return ctx.trigger.initial_kind ~= "trigger_character" and not require("blink.cmp").snippet_active()
        end,
        -- friendly-snippets maps global.json to both "markdown" and "all", so it loads twice
        transform_items = function(_, items)
          local seen = {}
          return vim.tbl_filter(function(item)
            local key = item.label .. (item.insertText or "")
            if seen[key] then
              return false
            end
            seen[key] = true
            return true
          end, items)
        end,
      },

      buffer = {
        min_keyword_length = 5,
        max_items = 5,
      },
    },
  },

  cmdline = {
    keymap = {
      preset = "cmdline",
    },

    completion = {
      list = {
        selection = {
          preselect = false,
        },
      },
      menu = {
        auto_show = true,
      },
    },
  },

  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 250,
      treesitter_highlighting = true,
      window = {
        border = "rounded",
      },
    },

    list = {
      selection = {
        preselect = false,
        auto_insert = true,
      },
    },

    trigger = {
      show_on_insert_on_trigger_character = false,
      show_on_accept_on_trigger_character = false,
    },

    menu = {
      border = "rounded",

      draw = {
        columns = {
          { "label", "label_description", gap = 1 },
          { "kind_icon" },
        },
      },
    },
  },
}

function M.add_default_source(name)
  if not vim.tbl_contains(M.opts.sources.default, name) then
    table.insert(M.opts.sources.default, name)
  end
end

function M.add_provider(name, provider)
  M.opts.sources.providers[name] = provider
end

return M

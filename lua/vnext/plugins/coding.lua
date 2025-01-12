return {
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "BufReadPost", "InsertLeave" },
    opts = {
      linters_by_ft = {
        dockerfile = { "hadolint" },
        go = { "golangcilint" },
        lua = { "selene" },
        markdown = { "markdownlint-cli2" },
        yaml = { "yamllint" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft
      local lint_augroup = vim.api.nvim_create_augroup("linting", { clear = true })
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- enable_check_bracket_line = false, -- Don't add pairs if it already has a close pair in the same line
      -- ignored_next_char = "[%w%.]", -- will ignore alphanumeric and `.` symbol
      check_ts = true, -- use treesitter to check for a pair.
      ts_config = {
        lua = { "string" }, -- it will not add pair on that treesitter node
        javascript = { "template_string" },
        java = false, -- don't check treesitter on java
      },
    },
  },

  {
    "hedyhli/outline.nvim",
    cmd = { "Outline", "OutlineOpen" },
    opts = {
      symbol_folding = {
        -- Depth past which nodes will be folded by default
        autofold_depth = 1,
      },
      guides = {
        enabled = false,
      },
    },
    keys = {
      { "<leader>to", "<cmd>Outline<cr>", desc = "Toggle Outline" },
    },
  },

  {
    "allaman/kustomize.nvim",
    dev = true,
    ft = "yaml",
    opts = {
      enable_lua_snip = true,
      kinds = {
        show_filepath = true,
        show_line = true,
      },
      run = {
        deprecations29 = {
          args = { "-t", "1.29", "-c=false", "--helm3=false", "-l=error", "-e", "-f" },
          cmd = "kubent",
        },
        deprecations30 = {
          args = { "-t", "1.30", "-c=false", "--helm3=false", "-l=error", "-e", "-f" },
          cmd = "kubent",
        },
        trivy = {
          args = { "-q", "fs" },
          cmd = "trivy",
        },
      },
    },
    config = function(_, opts)
      require("which-key").add({
        { "<leader>k", group = "Kustomize" },
      })
      require("kustomize").setup(opts)
    end,
  },
}

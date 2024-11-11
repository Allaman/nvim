local utils = require("utils.functions")

return {
  plugins = {
    nvim_lint = {
      enable = true,
      config_function = function(opts)
        local lint = require("lint")
        lint.linters_by_ft = opts.linters_by_ft
        local lint_augroup = vim.api.nvim_create_augroup("linting", { clear = true })
        vim.api.nvim_create_autocmd(opts.events, {
          group = lint_augroup,
          callback = function()
            lint.try_lint()
          end,
        })
        vim.api.nvim_create_user_command("DisableLinting", function()
          utils.notify("Disable Linting", vim.log.levels.INFO, "nvim-lint")
          local ft = vim.filetype.match({ buf = 0 })
          require("lint").linters_by_ft[ft] = {}
          vim.diagnostic.hide()
        end, { desc = "Disable linting for current filetype" })
        vim.keymap.set("n", "<leader>tL", "<cmd>DisableLinting<cr>", { desc = "Toggle Linting" })
      end,
      opts = {
        events = { "BufWritePost", "BufReadPost", "InsertLeave" },
        linters_by_ft = {
          dockerfile = { "hadolint" },
          go = { "golangcilint" },
          lua = { "selene" },
          yaml = { "yamllint" },
        },
      },
    },
  },
}

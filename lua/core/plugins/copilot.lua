return {
  "zbirenbaum/copilot.lua",
  build = ":Copilot auth",
  event = "InsertEnter",
  enabled = vim.g.config.plugins.copilot.enable,
  dependencies = {
    {
      "zbirenbaum/copilot-cmp",
      event = { "InsertEnter", "LspAttach" },
      config = function(_, opts)
        local function on_att(on_attach)
          vim.api.nvim_create_autocmd("LspAttach", {
            callback = function(args)
              local buffer = args.buf
              local client = vim.lsp.get_client_by_id(args.data.client_id)
              on_attach(client, buffer)
            end,
          })
        end
        local copilot_cmp = require("copilot_cmp")
        copilot_cmp.setup(opts)
        -- attach cmp source whenever copilot attaches
        -- fixes lazy-loading issues with the copilot cmp source
        -- https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/plugins/extras/coding/copilot.lua#L61
        on_att(function(client)
          if client.name == "copilot" then
            copilot_cmp._on_insert_enter({})
          end
        end)
      end,
    },
  },
  config = function()
    local utils = require("utils.functions")
    utils.map("n", "<leader>mc", "<cmd>Copilot enable<cr>", { desc = "Enable Copilot" })
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
    if vim.g.config.plugins.copilot.disable_autostart then
      -- HACK I want Copilot to only be enabled when I ask for it
      vim.cmd([[Copilot disable]])
    end
  end,
}

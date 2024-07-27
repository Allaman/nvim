local user_config = vim.g.config.plugins.gp or {}

local default_config = {
  enabled = false,
  keys = {
    { "<leader>i", "", desc = "+AI" },
    { "<leader>iv", "<cmd>GpChatNew vsplit<cr>", desc = "New Chat (vsplit)" },
    { "<leader>it", "<cmd>GpChatToggle<cr>", desc = "Toggle last chat" },
    { "<leader>if", "<cmd>GpChatFinder<cr>", desc = "Find chat" },
    { "<leader>id", "<cmd>GpChatDelete<cr>", desc = "Delete current chat" },
    { "<leader>ii", "<cmd>GpImage<cr>", desc = "Create an image" },
    { "<leader>is", "<cmd>GpStop<cr>", desc = "Stop all running jobs and responses" },
    { "<leader>il", "<cmd>GpTranslator vsplit<cr>", desc = "Translate" },
  },
  opts = {
    hooks = {
      Translator = function(gp, params)
        local chat_system_prompt = "You are a Translator, please translate between German and Engish."
        gp.cmd.ChatNew(params, chat_system_prompt)
      end,
    },
  },
  config_function = function(opts)
    require("gp").setup(opts)

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      pattern = { "*/gp/chats/*.md" },
      callback = function(args)
        vim.bo[args.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = args.buf, silent = true })
        vim.opt_local.spell = false
        vim.opt_local.list = false
      end,
      desc = "Configure gp.nvim chat buffer",
    })
    vim.api.nvim_create_autocmd({ "LspAttach" }, {
      pattern = { "*/gp/chats/*.md" },
      callback = function(args)
        -- Delay the detachment by a short period to ensure the LSP client is fully attached
        vim.defer_fn(function()
          vim.lsp.buf_detach_client(args.buf, args.data.client_id)
          vim.lsp.util.buf_clear_references(args.buf)
          vim.opt.winbar = "" -- dropbar is triggered by LspAttach
        end, 20) -- Delay in milliseconds
      end,
      desc = "Detach LSPs from gp.nvim chat buffer",
    })
  end,
}

local config = vim.tbl_deep_extend("force", default_config, user_config)

return {
  {
    "robitx/gp.nvim",
    lazy = true,
    enabled = config.enabled,
    keys = config.keys,
    opts = config.opts,
    config = function(_, opts)
      config.config_function(opts)
    end,
  },
}

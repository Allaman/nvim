-- TODO: replace with plain LSP https://www.lazyvim.org/extras/lang/go
local M = {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
  },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
  config = function()
    require("go").setup({
      -- NOTE: all LSP and formatting related options are disabeld.
      -- NOTE: is not related to core.plugins.lsp
      -- NOTE: manages LSP on its own
      max_line_len = 120, -- max line length in goline format
      lsp_cfg = true, -- true: use non-default gopls setup specified in go/lsp.lua
      -- false: do nothing
      -- if lsp_cfg is a table, merge table with with non-default gopls setup in go/lsp.lua, e.g.
      --   lsp_cfg = {settings={gopls={matcher='CaseInsensitive', ['local'] = 'your_local_module_path', gofumpt = true }}}
      lsp_on_attach = function(client, bufnr)
        -- attach my LSP configs keybindings
        require("core.plugins.lsp.keys").on_attach(client, bufnr)
        local wk = require("which-key")
        local default_options = { silent = true }
        wk.register({
          c = {
            name = "Coding",
            a = { "<cmd>GoCodeAction<cr>", "Code action" },
            e = { "<cmd>GoIfErr<cr>", "Add if err" },
            h = {
              name = "Helper",
              a = { "<cmd>GoAddTag<cr>", "Add tags to struct" },
              r = { "<cmd>GoRMTag<cr>", "Remove tags to struct" },
              c = { "<cmd>GoCoverage<cr>", "Test coverage" },
              g = { "<cmd>lua require('go.comment').gen()<cr>", "Generate comment" },
              v = { "<cmd>GoVet<cr>", "Go vet" },
              t = { "<cmd>GoModTidy<cr>", "Go mod tidy" },
              i = { "<cmd>GoModInit<cr>", "Go mod init" },
            },
            i = { "<cmd>GoToggleInlay<cr>", "Toggle inlay" },
            l = { "<cmd>GoLint<cr>", "Run linter" },
            o = { "<cmd>GoPkgOutline<cr>", "Outline" },
            r = { "<cmd>GoRun<cr>", "Run" },
            s = { "<cmd>GoFillStruct<cr>", "Autofill struct" },
            t = {
              name = "Tests",
              r = { "<cmd>GoTest<cr>", "Run tests" },
              a = { "<cmd>GoAlt!<cr>", "Open alt file" },
              s = { "<cmd>GoAltS!<cr>", "Open alt file in split" },
              v = { "<cmd>GoAltV!<cr>", "Open alt file in vertical split" },
              u = { "<cmd>GoTestFunc<cr>", "Run test for current func" },
              f = { "<cmd>GoTestFile<cr>", "Run test for current file" },
            },
            x = {
              name = "Code Lens",
              l = { "<cmd>GoCodeLenAct<cr>", "Toggle Lens" },
              a = { "<cmd>GoCodeAction<cr>", "Code Action" },
            },
          },
        }, { prefix = "<leader>", mode = "n", default_options })
        wk.register({
          c = {
            -- name = "Coding",
            j = { "<cmd>'<,'>GoJson2Struct<cr>", "Json to struct" },
          },
        }, { prefix = "<leader>", mode = "v", default_options })
      end,
      lsp_keymaps = false, -- set to false to disable gopls/lsp keymap
      lsp_document_formatting = false,
      lsp_inlay_hints = {
        enable = false,
      },
      dap_debug = false, -- set to false to disable dap
      dap_debug_keymap = false, -- true: use keymap for debugger defined in go/dap.lua
      dap_debug_gui = false, -- set to true to enable dap gui, highly recommended
      dap_debug_vt = false, -- set to true to enable dap virtual text
      luasnip = true,
    })
  end,
}

return M

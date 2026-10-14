local gh = require("config.util").gh

vim.pack.add({ gh("nvim-mini/mini.clue") })
local miniclue = require("mini.clue")
miniclue.setup({
  triggers = {
    -- Leader triggers
    { mode = { "n", "x" }, keys = "<Leader>" },

    -- `[` and `]` keys
    { mode = "n", keys = "[" },
    { mode = "n", keys = "]" },

    -- Built-in completion
    { mode = "i", keys = "<C-x>" },

    -- `g` key
    { mode = { "n", "x" }, keys = "g" },

    -- Marks
    { mode = { "n", "x" }, keys = "'" },
    { mode = { "n", "x" }, keys = "`" },

    -- Registers
    { mode = { "n", "x" }, keys = '"' },
    { mode = { "i", "c" }, keys = "<C-r>" },

    -- Window commands
    { mode = "n", keys = "<C-w>" },

    -- `z` key
    { mode = { "n", "x" }, keys = "z" },
  },

  window = {
    delay = 0,
  },

  clues = {
    -- Enhance this by adding descriptions for <Leader> mapping groups
    miniclue.gen_clues.square_brackets(),
    miniclue.gen_clues.builtin_completion(),
    miniclue.gen_clues.g(),
    miniclue.gen_clues.marks(),
    miniclue.gen_clues.registers(),
    -- TODO: use <c-w> ?
    miniclue.gen_clues.windows({ submode_resize = true }),
    miniclue.gen_clues.z(),
    { mode = "n", keys = "<Leader>b", desc = "+Buffers" },
    { mode = "n", keys = "<Leader>d", desc = "+Diagnostics" },
    { mode = "n", keys = "<Leader>f", desc = "+Files" },
    { mode = "n", keys = "<Leader>l", desc = "+LSP" },
    { mode = "n", keys = "<Leader>g", desc = "+Git" },
    { mode = "n", keys = "<Leader>r", desc = "+Search and Replace" },
    { mode = "n", keys = "<Leader>s", desc = "+Search" },
    { mode = "n", keys = "<Leader>t", desc = "+Toggles" },
    { mode = "n", keys = "<Leader>u", desc = "+UI" },
    { mode = "n", keys = "<Leader>w", desc = "+Window" },
  },
})

-- Snacks dashboard is an unlisted special buffer, so MiniClue does not
-- automatically install its trigger mappings there.
vim.api.nvim_create_autocmd("User", {
  pattern = "SnacksDashboardOpened",
  callback = function()
    miniclue.ensure_buf_triggers()
  end,
})

vim.pack.add({ gh("nvim-mini/mini.surround") })
require("mini.surround").setup({
  -- Number of lines within which surrounding is searched
  n_lines = 50,
})

vim.pack.add({ gh("nvim-mini/mini.align") })
require("mini.align").setup({})

vim.pack.add({ gh("nvim-mini/mini.comment") })
require("mini.comment").setup({})

vim.pack.add({ gh("nvim-mini/mini.icons") })
local icons = require("mini.icons")
icons.setup()
icons.mock_nvim_web_devicons()

vim.pack.add({ gh("nvim-mini/mini.ai") })
require("mini.ai").setup({})

vim.pack.add({ gh("nvim-mini/mini.hipatterns") })
local hipatterns = require("mini.hipatterns")
hipatterns.setup({
  highlighters = {
    bug = { pattern = "%f[%w]()BUG()%f[%W]", group = "MiniHipatternsFixme" },
    fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
    hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
    todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
    note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },

    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

local gh = require("config.util").gh

vim.pack.add({ gh("lewis6991/gitsigns.nvim") })

local gs = require("gitsigns")

gs.setup({
  current_line_blame_opts = {
    delay = 0,
  },

  signs = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
    untracked = { text = "▎" },
  },

  signs_staged = {
    add = { text = "▎" },
    change = { text = "▎" },
    delete = { text = "" },
    topdelete = { text = "" },
    changedelete = { text = "▎" },
  },

  on_attach = function(bufnr)
    local function map(mode, lhs, rhs, opts)
      opts = opts or {}
      opts.buffer = bufnr
      opts.silent = true
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- stylua: ignore start
    map("n", "gj", function() gs.nav_hunk("next") end, { desc = "Git Next hunk" })
    map("n", "gk", function() gs.nav_hunk("prev") end, { desc = "Git previous hunk" })
    map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage/unstage hunk" })
    map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage/unstage selected lines" })
    map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
    map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset selected lines" })
    map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
    map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
    map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle Blame line" })
    map("n", "<leader>gd", gs.preview_hunk_inline, { desc = "Show deleted" })
    -- stylua: ignore end
  end,
})

vim.pack.add({ { src = gh("kdheepak/lazygit.nvim") } })
-- TODO: requires plenary ...
vim.keymap.set("n", "<Leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
vim.keymap.set("n", "<leader>gF", "<cmd>LazyGitFilter<cr>", { desc = "History" })
vim.keymap.set("n", "<leader>gH", "<cmd>LazyGitFilterCurrentFile<cr>", { desc = "File history" })

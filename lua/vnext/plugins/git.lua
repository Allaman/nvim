return {
  {
    "tpope/vim-fugitive",
    cmd = "G",
    config = function()
      vim.g.fugitive_summary_format = "%<(16,trunc)%an || %s"
      local fugitive = vim.api.nvim_create_augroup("Fugitive", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        group = fugitive,
        pattern = { "fugitiveblame", "fugitive" },
        callback = function()
          vim.cmd("resize 30") -- For horizontal split, 20 lines tall
          vim.keymap.set("n", "q", function()
            -- Check if there's a snacks dashboard buffer in any window
            local dashboard_buf = nil
            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
              if vim.bo[buf].filetype == "snacks_dashboard" then
                dashboard_buf = buf
                break
              end
            end

            vim.cmd("close") -- Close fugitive

            -- If we ended up on an empty/new buffer and snacks dashboard exists, go back to it
            if not dashboard_buf then
              return
            end

            if vim.bo.buftype == "nofile" or vim.api.nvim_buf_get_name(0) == "" then
              vim.api.nvim_win_set_buf(0, dashboard_buf)
            end
          end, { buffer = true })
        end,
        desc = "Close fugitive with q and return to dashboard if opened from there",
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = fugitive,
        pattern = { "git" },
        callback = function()
          vim.opt_local.foldmethod = "syntax"
          vim.opt_local.foldlevel = 0
          vim.opt_local.foldenable = true
        end,
      })

      vim.api.nvim_create_user_command("Gcn", function(opts)
        local branch_name = opts.args
        if branch_name == "" then
          vim.notify("Error: Branch name is required", vim.log.levels.ERROR)
          return
        end
        vim.cmd("Git checkout -b " .. branch_name)
      end, {
        nargs = 1,
        desc = "Create and checkout new git branch",
      })
    end,
    keys = {
      { "<leader>gg", "<cmd>G<cr>", desc = "G" },
      { "<leader>gfl", "<cmd>GcLog<cr>", desc = "Difflog" },
      { "<leader>gff", "<cmd>0GcLog<cr>", desc = "Difflog file" },
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
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
        local gs = require("gitsigns")
        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          opts.silent = true
          vim.keymap.set(mode, l, r, opts)
        end
      -- stylua: ignore start
      map("n", "gj", function() gs.nav_hunk("next") end, { desc = "Git Next hunk" })
      map("n", "gk", function() gs.nav_hunk("prev") end, { desc = "Git previous hunk" })
      map("n", "<leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
      map("v", "<leader>gu", function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end, { desc = "Undo stage hunk" })
      map("n", "<leader>gr", gs.reset_hunk, { desc = "Reset Hunk" })
      map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset Hunk" })
      map("n", "<leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
      map("n", "<leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
      map("n", "<leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
      map("n", "<leader>gb", gs.toggle_current_line_blame, { desc = "Toggle Blame line" })
      map("n", "<leader>gd", gs.preview_hunk_inline, { desc = "Show deleted" })
      end,
      -- stylua: ignore end
    },
    keys = {
      { "<leader>g", "", desc = "+Git" },
    },
    config = function(_, opts)
      require("gitsigns").setup(opts)
    end,
  },
  -- {
  --   "sindrets/diffview.nvim",
  --   cmd = { "DiffviewFileHistory", "DiffviewOpen" },
  --   keys = {
  --     { "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
  --     { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "History" },
  --     { mode = "v", "<leader>gH", ":DiffviewFileHistory<cr>", desc = "History (range)" },
  --     { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Gitdiff" },
  --   },
  -- },
  -- TODO: Replace diffview when Filehistory is available?
  -- {
  --   "esmuellert/codediff.nvim",
  --   cmd = "CodeDiff",
  -- },
  {
    "NeogitOrg/neogit",
    cmd = { "Neogit" },
    dependencies = {
      {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewFileHistory", "DiffviewOpen" },
        keys = {
          { "<leader>gF", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
          { "<leader>gH", "<cmd>DiffviewFileHistory<cr>", desc = "History" },
          { mode = "v", "<leader>gH", ":DiffviewFileHistory<cr>", desc = "History (range)" },
          { "<leader>gD", "<cmd>DiffviewOpen<cr>", desc = "Gitdiff" },
        },
      },
    },
  },
}

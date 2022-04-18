local vo = vim.opt_local
vo.tabstop = 2
vo.shiftwidth = 2
vo.softtabstop = 2

local wk = require("which-key")
default_options = { silent = true }
wk.register({
	y = {
		name = "YAML",
		s = { "<cmd>YAMLView<cr>", "Show Path" },
		q = { "<cmd>YAMLQuickfix<cr>", "Generate quickfix list" },
		t = { "<cmd>YAMLTelescope<cr>", "Open Telescope" },
		k = { "<cmd>YAMLYankKey<cr>", "Yank key" },
		v = { "<cmd>YAMLYankValue<cr>", "Yank value" },
	},
}, { prefix = "<leader>", mode = "n", default_options })

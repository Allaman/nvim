local vo = vim.opt_local
vo.tabstop = 4
vo.shiftwidth = 4
vo.softtabstop = 4

local wk = require("which-key")
default_options = { silent = true }
wk.register({
	c = {
		name = "Coding",
		a = { "<cmd>GoAddTag<cr>", "Add tags to struct" },
		c = { "<cmd>GoCoverage<cr>", "Test coverage" },
		e = { "<cmd>GoIfErr<cr>", "Add if err" },
		g = { "<cmd>lua require('go.comment').gen()<cr>", "Generate comment" },
		l = { "<cmd>GoLint<cr>", "Run linter" },
		r = { "<cmd>GoRun<cr>", "Run" },
		s = { "<cmd>GoFillStruct<cr>", "Autofill struct" },
		t = { "<cmd>GoTest<cr>", "Run tests" },
		v = { "<cmd>GoVet<cr>", "Go vet" },
	},
}, { prefix = "<leader>", mode = "n", default_options })

-- disable v
-- local presets = require("which-key.plugins.presets")
-- presets.operators["v"] = nil
require("which-key").setup({
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 2, -- spacing between columns
		align = "center", -- align columns left, center or right
	},
	ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
	hidden = {
		"<silent>",
		"<cmd>",
		"<Cmd>",
		"<cr>",
		"<CR>",
		"call",
		"lua",
		"require",
		"^:",
		"^ ",
	}, -- hide mapping boilerplate
	show_help = false, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
})

local wk = require("which-key")
local default_options = { silent = true }

-- register non leader based mappings
wk.register({
	ga = { "<Plug>(EasyAlign)", "Align", mode = "x" },
	sa = "Add surrounding",
	sd = "Delete surrounding",
	sh = "Highlight surrounding",
	sn = "Surround update n lines",
	sr = "Replace surrounding",
	sF = "Find left surrounding",
	sf = "Replace right surrounding",
	ss = { "<Plug>Lightspeed_s", "Search 2-character forward" },
	-- SS = {"<Plug>Lightspeed_S", "Search 2-character backward"}
	st = { "<cmd>lua require('tsht').nodes()<cr>", "TS hint textobject" },
})

-- Register all leader based mappings
wk.register({
	["<Tab>"] = { "<cmd>e#<cr>", "Prev buffer" },
	["<leader>"] = {
		name = "Leader",
		a = { "<cmd>lua print('fasfAS')<cr>", "test" },
	},
	b = {
		name = "Buffers",
		b = {
			"<cmd>Telescope buffers<cr>",
			"Find buffer",
		},
		a = {
			"<cmd>BufferLineCloseLeft<cr><cmd>BufferLineCloseRight<cr>",
			"Close all but the current buffer",
		},
		d = { "<cmd>Bdelete!<CR>", "Close buffer" },
		f = { "<cmd>BufferLinePick<cr>", "Pick buffer" },
		l = { "<cmd>BufferLineCloseLeft<cr>", "Close all buffers to the left" },
		p = { "<cmd>BufferLineMovePrev<cr>", "Move buffer prev" },
		n = { "<cmd>BufferLineMoveNext<cr>", "Move buffer next" },
		r = {
			"<cmd>BufferLineCloseRight<cr>",
			"Close all BufferLines to the right",
		},
		x = {
			"<cmd>BufferLineSortByDirectory<cr>",
			"Sort BufferLines automatically by directory",
		},
		L = {
			"<cmd>BufferLineSortByExtension<cr>",
			"Sort BufferLines automatically by extension",
		},
	},
	f = {
		name = "Files",
		b = { "<cmd>Telescope file_browser<cr>", "File browser" },
		f = {
			"<cmd>lua require'telescope.builtin'.find_files()<cr>",
			"Find File",
		},
		l = { "<cmd>Lf<cr>", "Open LF" },
		p = { "<cmd>NvimTreeToggle<cr>", "Toggle Tree" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		s = { "<cmd>w<cr>", "Save Buffer" },
		T = { "<cmd>NvimTreeFindFile<CR>", "Find in Tree" },
		z = { "<cmd>Telescope zoxide list<CR>", "Zoxide" },
	},
	g = {
		name = "Git",
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>Telescope git_commits<cr>", "Log" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		S = { "<cmd>lua require 'gitsigns'.stage_buffer()<cr>", "Stage Buffer" },
		t = "Open Gitui", -- command in toggleterm.lua
		n = { "<cmd>Neogit<cr>", "Open Neogit" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		g = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		B = { "<cmd>GitBlameToggle<cr>", "Toggle Blame" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		C = {
			"<cmd>Telescope git_bcommits<cr>",
			"Checkout commit(current file)",
		},
	},
	h = {
		name = "Harpoon",
		a = { "<cmd>lua require('harpoon.mark').add_file()<cr>", "Add file" },
		u = {
			"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
			"Open Menu",
		},
		["1"] = {
			"<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
			"Open File 1",
		},
		["2"] = {
			"<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
			"Open File 2",
		},
		["3"] = {
			"<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
			"Open File 3",
		},
		["4"] = {
			"<cmd>lua require('harpoon.ui').nav_file(1)<cr>",
			"Open File 4",
		},
	},
	m = {
		name = "Misc",
		a = {
			"<cmd>lua require'telegraph'.telegraph({cmd='gitui', how='tmux_popup'})<cr>",
			"Test Telegraph",
		},
		d = { "<cmd>lua require('functions').toggle_diagnostics()<cr>", "Toggle Diagnostics" },
		l = { "<cmd>source ~/.config/nvim/snippets/*<cr>", "Reload snippets" },
		p = { "<cmd>PackerSync<cr>", "PackerSync" },
		s = { "<cmd>SymbolsOutline<cr>", "Toggle SymbolsOutline" },
		t = { "<cmd>FloatermNew --autoclose=2<cr>", "New Floaterm" },
		z = { "<cmd>ZenMode<cr>", "Toggle ZenMode" },
	},
	q = {
		name = "Quickfix",
		j = { "<cmd>cnext<cr>", "Next Quickfix Item" },
		k = { "<cmd>cprevious<cr>", "Previous Quickfix Item" },
		q = { "<cmd>lua require('functions').toggle_qf()<cr>", "Toggle quickfix list" },
		t = { "<cmd>TodoQuickFix<cr>", "Show TODOs" },
	},
	s = {
		name = "Search",
		C = { "<cmd>CheatSH<cr>", "Cht.sh" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		H = { "<cmd>Telescope heading<cr>", "Find Header" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		t = { "<cmd>Telescope live_grep<cr>", "Text" },
		s = { "<cmd>Telescope grep_string<cr>", "Text under cursor" },
		S = { "<cmd>Telescope symbols<cr>", "Search symbols" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		c = { "<cmd>Telescope commands<cr>", "Commands" },
		p = { "<cmd>Telescope projects<cr>", "Projects" },
		P = { "<cmd>Telescope builtin<cr>", "Builtin pickers" },
		z = { "<cmd>Telescope packer<cr>", "Plugins" },
	},
	w = {
		name = "Window",
		p = { "<c-w>x", "Swap" },
		q = { "<cmd>:q<cr>", "Close" },
		s = { "<cmd>:split<cr>", "Horizontal Split" },
		t = { "<c-w>t", "Move to new tab" },
		["="] = { "<c-w>=", "Equally size" },
		v = { "<cmd>:vsplit<cr>", "Verstical Split" },
		w = {
			"<cmd>lua require('nvim-window').pick()<cr>",
			"Choose window to jump",
		},
	},
	x = {
		name = "LanguageTool",
		c = { "<cmd>GrammarousCheck<cr>", "Grammar check" },
		i = { "<Plug>(grammarous-open-info-window)", "Open the info window" },
		r = { "<Plug>(grammarous-reset)", "Reset the current check" },
		f = { "<Plug>(grammarous-fixit)", "Fix the error under the cursor" },
		x = {
			"<Plug>(grammarous-close-info-window)",
			"Close the information window",
		},
		e = {
			"<Plug>(grammarous-remove-error)",
			"Remove the error under the cursor",
		},
		n = {
			"<Plug>(grammarous-move-to-next-error)",
			"Move cursor to the next error",
		},
		p = {
			"<Plug>(grammarous-move-to-previous-error)",
			"Move cursor to the previous error",
		},
		d = {
			"<Plug>(grammarous-disable-rule)",
			"Disable the grammar rule under the cursor",
		},
	},
	z = {
		name = "Spelling",
		n = { "]s", "Next" },
		p = { "[s", "Previous" },
		a = { "zg", "Add word" },
		f = { "1z=", "Use 1. correction" },
		l = { "<cmd>Telescope spell_suggest<cr>", "List corrections" },
	},
}, { prefix = "<leader>", mode = "n", default_options })

local telescope = require("telescope")
local actions = require("telescope.actions")
local action_layout = require("telescope.actions.layout")

telescope.load_extension("projects")
telescope.load_extension("fzf")
telescope.load_extension("zoxide")
telescope.load_extension("heading")
telescope.load_extension("file_browser")

telescope.setup({
	defaults = {
		file_ignore_patterns = { "node_modules", ".terraform", "%.jpg", "%.png" },
		vimgrep_arguments = {
			"rg",
			"--follow",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		mappings = {
			i = {
				-- Close on first esc instead of gonig to normal mode
				-- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/mappings.lua
				["<esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,
				["<C-k>"] = actions.move_selection_previous,
				["<A-q>"] = actions.send_selected_to_qflist,
				["<C-q>"] = actions.send_to_qflist,
				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<cr>"] = actions.select_default,
				["<c-v>"] = actions.select_vertical,
				["<c-s>"] = actions.select_horizontal,
				["<c-t>"] = actions.select_tab,
				["<c-p>"] = action_layout.toggle_preview,
				["<c-o>"] = action_layout.toggle_mirror,
				["<c-h>"] = actions.which_key,
			},
		},
		prompt_prefix = "> ",
		selection_caret = " ",
		entry_prefix = "  ",
		multi_icon = "<>",
		initial_mode = "insert",
		scroll_strategy = "cycle",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
			width = 0.95,
			height = 0.85,
			-- preview_cutoff = 120,
			prompt_position = "top",
			horizontal = {
				preview_width = function(_, cols, _)
					if cols > 200 then
						return math.floor(cols * 0.4)
					else
						return math.floor(cols * 0.6)
					end
				end,
			},
			vertical = { width = 0.9, height = 0.95, preview_height = 0.5 },
			flex = { horizontal = { preview_width = 0.9 } },
		},
		file_sorter = require("telescope.sorters").get_fzf_sorter,
		generic_sorter = require("telescope.sorters").get_fzf_sorter,
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
	},
})

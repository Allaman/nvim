local utils = require("functions")
require("bufferline").setup({
	options = {
		numbers = function(opts)
			return string.format("%s", opts.id) -- :h bufferline-numbers
		end,
		close_command = utils.bufdelete, -- can be a string | function, see "Mouse actions"
		right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
		left_mouse_command = "buffer %d", -- can be a string | function, see "Mouse actions"
		middle_mouse_command = nil, -- can be a string | function, see "Mouse actions"
		indicator_icon = " ",
		buffer_close_icon = "",
		modified_icon = "●",
		close_icon = "",
		left_trunc_marker = "",
		right_trunc_marker = "",
		max_name_length = 18,
		max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
		tab_size = 18,
		diagnostics = "nvim_lsp",
		diagnostics_indicator = function(count, level)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
		-- NOTE: this will be called a lot so don't do any heavy processing here
		custom_filter = function(buf_number, buf_numbers)
			-- filter out filetypes you don't want to see
			if vim.bo[buf_number].filetype ~= "qf" then
				return true
			else
				return false
			end
			-- filter out by buffer name
			-- if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
			-- 	return true
			-- else
			-- 	return false
			-- end
			-- filter out based on arbitrary rules
			-- e.g. filter out vim wiki buffer from tabline in your work repo
			-- if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
			-- 	return true
			-- else
			-- 	return false
			-- end
			-- filter out by it's index number in list (don't show first buffer)
			-- if buf_numbers[1] ~= buf_number then
			-- 	return true
			-- else
			-- 	return false
			-- end
		end,
		offsets = {
			{
				filetype = "NvimTree",
				text = " File Explorer",
				highlight = "Directory",
				text_align = "left",
				padding = 1,
			},
		},
		show_buffer_icons = true, -- disable filetype icons for buffers
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = true,
		persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
		-- can also be a table containing 2 custom separators
		-- [focused and unfocused]. eg: { '|', '|' }
		separator_style = "thin",
		enforce_regular_tabs = false,
		always_show_bufferline = false,
		sort_by = "id",
	},
})

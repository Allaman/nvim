local cmd = vim.cmd
local fn = vim.fn

local M = {}

-- check if a variable is not empty nor nil
M.isNotEmpty = function(s)
	return s ~= nil and s ~= ""
end

-- toggle quickfixlist
M.toggle_qf = function()
	local windows = fn.getwininfo()
	local qf_exists = false
	for _, win in pairs(windows) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end
	if qf_exists == true then
		cmd("cclose")
		return
	end
	if M.isNotEmpty(fn.getqflist()) then
		cmd("copen")
	end
end

-- move over a closing element in insert mode
M.escapePair = function()
	local closers = { ")", "]", "}", ">", "'", '"', "`", "," }
	local line = vim.api.nvim_get_current_line()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local after = line:sub(col + 1, -1)
	local closer_col = #after + 1
	local closer_i = nil
	for i, closer in ipairs(closers) do
		local cur_index, _ = after:find(closer)
		if cur_index and (cur_index < closer_col) then
			closer_col = cur_index
			closer_i = i
		end
	end
	if closer_i then
		vim.api.nvim_win_set_cursor(0, { row, col + closer_col })
	else
		vim.api.nvim_win_set_cursor(0, { row, col + 1 })
	end
end

diagnostics_active = true -- must be global since this function is called in which.lua
M.toggle_diagnostics = function()
	diagnostics_active = not diagnostics_active
	if diagnostics_active then
		vim.diagnostic.show()
	else
		vim.diagnostic.hide()
	end
end

return M

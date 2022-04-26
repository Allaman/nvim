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

return M

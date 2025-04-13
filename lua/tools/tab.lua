local M = {}
function M.setup()
	local pairs = {
		'"',
		"'",
		")",
		"}",
		"]",
	}
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local line = vim.api.nvim_get_current_line()
	col = col + 1
	local char = line:sub(col, col)
	for _, i in ipairs(pairs) do
		if char == i then
			-- 在插入模式下发送 <Right> 键
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Right>", true, false, true), "i", true)
			return
		end
	end
	-- 直接插入四个空格
	vim.api.nvim_feedkeys("    ", "i", true)
end
return M

-- mini.nvim
require('mini.jump').setup()
require('mini.pairs').setup()
require('mini.tabline').setup({
    show_icons = false,
})


require("mini.surround").setup({
	-- 启用/禁用模块（默认 true）
	enable = true,

	-- 默认环绕符号映射
	mappings = {
		add = "ya", -- 添加环绕符号（示例: `saiw(` 为单词添加括号）
		delete = "yd", -- 删除环绕符号
		find = "yf", -- 查找右侧环绕符号
		find_left = "yF", -- 查找左侧环绕符号
		highlight = "yh", -- 高亮环绕区域
		replace = "yr", -- 替换环绕符号
		update_n_lines = "yn", -- 更新受影响行数
	},

	-- 高亮持续时间（毫秒）
	highlight_duration = 500,

	-- 输入模式下的提示行为
	input_n_lines = 3, -- 显示多少行输入提示
	input_after_timeout = 200, -- 输入超时时间（毫秒）
})


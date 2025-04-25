-- mini.nvim

-- 覆盖 MiniJump 高亮组（方块背景 + 无下划线）
vim.api.nvim_set_hl(0, "MiniJump", {
  fg = "#FFFFFF",     -- 文字颜色（白色）
  bg = "#FF0000",     -- 背景颜色（红色方块）
  underline = false,  -- 关闭下划线
  bold = true,        -- 加粗文字
})
require('mini.jump').setup()

require('mini.pairs').setup()
require('mini.tabline').setup({
    show_icons = false,
})


-- 在 init.lua 中添加配置
require('mini.ai').setup({
  custom_objects = {
    -- 选择函数体（def ... : 后的代码块）
    f = {
      -- 使用正则匹配 def 函数
      pattern = [[\bdef\s+\w+($.*$)\s*:\n\s+.*\n\ze^\S]],
      selection_type = 'linewise',
    },
    -- 选择类定义（class ... : 后的代码块）
    c = {
      pattern = [[\bclass\s+\w+($.*$)?\s*:\n\s+.*\n\ze^\S]],
      selection_type = 'linewise',
    },
  },
})

require('mini.comment').setup()

require("mini.surround").setup({
	-- 启用/禁用模块（默认 true）
	enable = true,

	-- 默认环绕符号映射
	mappings = {
		add = "xa", -- 添加环绕符号（示例: `saiw(` 为单词添加括号）
		delete = "xd", -- 删除环绕符号
		replace = "xr", -- 替换环绕符号
	},

	-- 高亮持续时间（毫秒）
	highlight_duration = 500,

	-- 输入模式下的提示行为
	input_n_lines = 3, -- 显示多少行输入提示
	input_after_timeout = 200, -- 输入超时时间（毫秒）
})

require('mini.trailspace').setup({
  -- 高亮样式（默认红色波浪线）
  hl = 'MiniTrailspace',
  -- 禁用特定文件类型（如 Markdown 允许末尾空格）
  disable_filetypes = { 'markdown', 'text' },
  -- 触发高亮的时机（默认 `BufReadPost` 和 `TextChanged`）
  find_in_events = { 'BufReadPost', 'TextChanged' },
  -- 是否在保存时自动清理（谨慎启用，避免意外修改）
  remove_on_save = false,
})


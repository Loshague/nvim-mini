local opt = vim.opt
vim.g.mapleader = ' '


-- 将"寄存器关联到+上，这样复制等操作会直接放到系统粘贴板上
opt.clipboard = "unnamed"


-- 界面与显示
opt.termguicolors = true      -- 	启用 24 位真彩色支持（需终端支持）
opt.ttyfast = true            --  优化终端渲染性能（现代终端可忽略）
opt.cursorline = true         --  高亮当前行
opt.number = true             --  显示行号
opt.relativenumber = true
opt.showtabline = 1           --  仅在多个标签页时显示标签栏（0：不显示，2：始终显示）
opt.laststatus = 3            --  全局状态栏（单一行显示，适合分屏）
--opt.signcolumn = 'yes'        --  始终显示标记列（用于 LSP 错误提示等）
opt.conceallevel = 0          --  禁用文本隐藏（如 JSON 中的引号）
opt.winwidth = 30             -- 设置当前窗口的宽度为 30 个字符
opt.pumheight = 15            --  补全菜单最大高度为 15 行
opt.list = true               --  显示不可见字符（如制表符、空格）
opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'  
                              --  自定义不可见字符的显示符号

-- 编辑行为
opt.wrap = true               --  启用自动换行
opt.virtualedit = 'block'     --  允许光标在块模式下移动到行尾之后
opt.breakindent = true        --  换行时保持缩进

-- 设置撤销文件存储目录（需手动创建）
opt.undodir = vim.fn.stdpath("data") .. "/undo"
opt.undofile = true           --  启用持久化撤销（保存撤销历史到文件）

-- 缩进与制表符
opt.tabstop = 4               --  制表符显示为 4 个空格宽度
opt.shiftwidth = 4            --  自动缩进时每级缩进 4 个空格
opt.softtabstop = 2           --  按 Tab 键插入 2 个空格
opt.expandtab = true          --  将 Tab 转换为空格
opt.smarttab = true           --  在行首按 Tab 使用 shiftwidth，否则插入空格
opt.autoindent = true         --  继承上一行缩进
opt.smartindent = true        --  基于语法智能缩进（如 C 语言）

-- 搜索与匹配
opt.ignorecase = true         --  搜索时忽略大小写
opt.smartcase = true          --  若搜索词包含大写字母，则启用大小写敏感
opt.wildmenu = true           --  启用命令行补全菜单
-- 退出查找后，关闭高亮
opt.hlsearch = false

-- 性能与响应
opt.ttimeoutlen = 0           --  键映射超时时间为 0 毫秒（立即生效）
opt.timeout = false           --  禁用键映射超时（避免中途取消映射）
opt.updatetime = 100          --  键入后 100 毫秒触发 CursorHold 事件（用于 LSP 提示等）
opt.redrawtime = 1500         --  重绘超时时间为 1500 毫秒（影响大文件渲染）

-- 其他配置
opt.showmode = false          --  禁用模式提示（如 -- INSERT --，通常由状态栏插件替代）
opt.cmdheight = 1             --  命令行高度为 0（自动调整，需 Neovim 0.9+）
opt.scrolloff = 7             --  垂直滚动时光标上下保留 7 行
opt.sidescrolloff = 7         --  水平滚动时光标左右保留 7 列
opt.colorcolumn = '0'         --  禁用右侧参考线（设为 80 可标记列宽）
opt.spelloptions = 'camel'    --  拼写检查时识别驼峰命名（需 Neovim 0.9.5+）

-- 折叠与填充字符
opt.foldmethod = 'indent'     --  基于缩进折叠代码
opt.foldlevel = 99            --  默认展开所有折叠


-- 将文件末尾后的虚拟行占位符设为空格
opt.fillchars = {
  eob = " ", -- 替换波浪线为空格（视觉上隐藏）
}

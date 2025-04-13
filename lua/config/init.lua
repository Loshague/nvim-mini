-- 将plugins内的插件放进加载目录
local path = vim.fn.stdpath('config') .. '/lua/plugins/*'
vim.opt.rtp:prepend(path)

vim.cmd.colorschem('github_light')

require('config.options')
require('config.core')
require('config.keymap')
require('config.plugin')




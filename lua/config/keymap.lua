vim.keymap.set('n', '<leader>2', '<cmd>edit ~/.config/nvim/init.lua<cr>')
vim.keymap.set('n', '<leader>9', '<cmd>source %<cr>')
vim.keymap.set('n', 'H', '<cmd>bpre<cr>')
vim.keymap.set('n', 'L', '<cmd>bnext<cr>')


-- window
vim.keymap.set('n', '<C-h>', '<C-w>h')
vim.keymap.set('n', '<C-j>', '<C-w>j')
vim.keymap.set('n', '<C-k>', '<C-w>k')
vim.keymap.set('n', '<C-l>', '<C-w>l')

vim.keymap.set('t', '<C-k>', '<C-\\><C-n>')

-- Insert
vim.keymap.set('i', '<C-a>', '<esc>^i')
vim.keymap.set('i', '<C-e>', '<esc>$a')
vim.keymap.set('i', '<C-f>', '<right>')
vim.keymap.set('i', '<C-b>', '<left>')
vim.keymap.set('i', '<Tab>', require('tools.tab').setup)

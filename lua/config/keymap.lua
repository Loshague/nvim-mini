vim.keymap.set('n', '<leader>2', '<cmd>edit ~/.config/nvim/init.lua<cr>')
vim.keymap.set('n', '<leader>9', '<cmd>source %<cr>')
vim.keymap.set('n', 'H', '<cmd>bpre<cr>')
vim.keymap.set('n', 'L', '<cmd>bnext<cr>')

vim.keymap.set('i', '<C-e>', '<esc>$a')
vim.keymap.set('i', '<C-a>', '<esc>^i')

vim.keymap.set('t', '<C-k>', '<C-\\><C-n>')

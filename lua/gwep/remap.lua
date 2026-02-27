-- set cursor to center of screen when jumping half a page up or down
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Move half page up and center cursor' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Move half page down and center cursor' })

-- easier windows switching commands
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move focus to window below' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move focus to window above' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to window on the left' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to window on the right' })

-- open explorer for directory of current file
vim.keymap.set('n', '<leader>e', vim.cmd.Ex, { desc = 'Open explorer for directory of current file' })

vim.keymap.set('t',  '<Esc>', '<C-\\><C-N>', { desc = "Exit terminal mode" })

vim.keymap.set('n', '<leader>w', vim.cmd.tabnew, { desc = 'Open new tab' })
vim.keymap.set('n', '<leader>W', vim.cmd.tabclose, { desc = 'Close current tab' })

vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>fe', vim.cmd.Ex)

vim.keymap.set('i', '<C-h>', '<Left>')
vim.keymap.set('i', '<C-j>', '<Down>')
vim.keymap.set('i', '<C-k>', '<Up>')
vim.keymap.set('i', '<C-l>', '<Right>')

-- Format Document
vim.keymap.set('n', '<leader>fd', 'gg=G<C-o>')
-- Copy Whole Document to System Clipboard
vim.keymap.set('n', '<leader>yg', 'gg"+yG<C-o>')

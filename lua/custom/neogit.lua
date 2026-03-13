require('neogit').setup({})
vim.keymap.set('n', '<leader>Go', '<cmd>Neogit<cr>', { desc = 'Open Neogit' })
vim.keymap.set('n', '<leader>Gd', '<cmd>Neogit diff <cr>', { desc = 'Open Neogit Diff' })

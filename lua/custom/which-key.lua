local wk = require('which-key')

local opts = {
    preset = 'modern',
}

wk.setup(opts)

vim.keymap.set('n', '<leader>?', function()
    require('which-key').show({ global = false })
end, { desc = 'Buffer Local Keymaps (which-key)' })

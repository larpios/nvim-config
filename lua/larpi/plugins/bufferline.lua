return {
    -- Tabs
    'akinsho/bufferline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {},
    keys = {
        { 'L', '<cmd>BufferLineCycleNext<cr>', mode = 'n', desc = '[Bufferline] Next Buffer' },
        { 'H', '<cmd>BufferLineCyclePrev<cr>', mode = 'n', desc = '[Bufferline] Previous Buffer' },
        { '<leader>>', '<cmd>BufferLineMoveNext<cr>', mode = 'n', desc = '[Bufferline] Move Buffer to the Right' },
        { '<leader><', '<cmd>BufferLineMovePrev<cr>', mode = 'n', desc = '[Bufferline] Move Buffer to the Left' },
        { '<leader>bc', '<cmd>BufferLinePickClose<cr>', mode = 'n', desc = '[Bufferline] Close buffer' },
        { '<leader>bp', '<cmd>BufferLinePick<cr>', mode = 'n', desc = '[Bufferline] Pick Buffer' },
        { '<leader>br', '<cmd>BufferLineTabRename<cr>', mode = 'n', desc = '[Bufferline] Rename Tab' },
    },
}

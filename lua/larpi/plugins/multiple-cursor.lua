return {
    'brenton-leighton/multiple-cursors.nvim',
    version = '*', -- Use the latest tagged version
    opts = {}, -- This causes the plugin setup function to be called
    keys = {
        { '<leader><leader>k', '<Cmd>MultipleCursorsAddUp<CR>', mode = { 'n', 'x' }, desc = '[MultipleCursor] Add cursor and move up' },
        { '<leader><leader>j', '<Cmd>MultipleCursorsAddDown<CR>', mode = { 'n', 'x' }, desc = '[MultipleCursor] Add cursor and move down' },

        { '<C-k>', '<Cmd>MultipleCursorsAddUp<CR>', mode = { 'i', 'x' }, desc = '[MultipleCursor] Add cursor and move up' },
        { '<C-j>', '<Cmd>MultipleCursorsAddDown<CR>', mode = { 'i', 'x' }, desc = '[MultipleCursor] Add cursor and move down' },

        { '<C-LeftMouse>', '<Cmd>MultipleCursorsMouseAddDelete<CR>', mode = { 'n', 'i' }, desc = '[MultipleCursor] Add or remove cursor' },

        { '<leader>m', '<Cmd>MultipleCursorsAddVisualArea<CR>', mode = { 'x' }, desc = '[MultipleCursor] Add cursors to the lines of the visual area' },

        { '<leader>ma', '<Cmd>MultipleCursorsAddMatches<CR>', mode = { 'n', 'x' }, desc = '[MultipleCursor] Add cursors to cword' },
        { '<leader>mv', '<Cmd>MultipleCursorsAddMatchesV<CR>', mode = { 'n', 'x' }, desc = '[MultipleCursor] Add cursors to cword in previous area' },

        -- { '<leader>man', '<Cmd>MultipleCursorsAddJumpNextMatch<CR>', mode = { 'n', 'x' }, desc = '[MultipleCursor] Add cursor and jump to next cword' },
        -- { '<leader>mn', '<Cmd>MultipleCursorsJumpNextMatch<CR>', mode = { 'n', 'x' }, desc = '[MultipleCursor] Jump to next cword' },

        { '<leader>ml', '<Cmd>MultipleCursorsLock<CR>', mode = { 'n', 'x' }, desc = '[MultipleCursor] Lock virtual cursors' },
    },
}

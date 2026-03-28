return {
    -- Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
    'chrisgrieser/nvim-spider',
    config = true,
    event = 'BufReadPost',
    keys = {
        {
            'w',
            function()
                require('spider').motion('w')
            end,
            mode = { 'n', 'o', 'x' },
            desc = 'Spider-w',
        },
        {
            'e',
            function()
                require('spider').motion('e')
            end,
            mode = { 'n', 'o', 'x' },
            desc = 'Spider-e',
        },
        {
            'b',
            function()
                require('spider').motion('b')
            end,
            mode = { 'n', 'o', 'x' },
            desc = 'Spider-b',
        },
        {
            '<C-f>',
            function()
                vim.cmd('norm l')
                require('spider').motion('w')
            end,
            mode = 'i',
            desc = '[Spider] Move Forward Word',
        },
        {
            '<C-b>',
            function()
                require('spider').motion('b')
            end,
            mode = 'i',
        },
    },
}

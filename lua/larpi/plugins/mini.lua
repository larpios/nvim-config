return {
    'nvim-mini/mini.nvim',
    lazy = false,
    version = false,
    keys = {
        {
            '<leader>tm',
            function()
                require('mini.files').open()
            end,
            desc = '[Mini] Open Mini Files',
        },
        {
            '<leader>mf',
            function()
                require('mini.files').open()
            end,
            desc = '[Mini] Open Mini Files',
        },
    },
    config = function()
        -- mini.align is a module that aligns text in visual mode
        require('mini.align').setup({})
        require('mini.keymap').setup({})
        -- require('mini.pairs').setup({})
        --
        require('mini.tabline').setup({})

        -- mini.ai is a module that provides more text objects, especially for ones that start with `a(round)`, and `i(nside)`
        -- Check out the documentation for more information (https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-ai.md)
        require('mini.ai').setup({})
        require('mini.diff').setup({
            mappings = {
                apply = 'gq',
                reset = 'gQ',
                textobject = 'gq',

                goto_first = '[H',
                goto_prev = '[h',
                goto_next = '[h',
                goto_last = ']H',
            },
        })
        require('mini.surround').setup({
            respect_selection_type = true,
        })
        require('mini.cmdline').setup()
        require('mini.move').setup({
            mappings = {
                -- In Visual Mode
                left = '<leader>mh',
                right = '<leader>ml',
                down = '<leader>mj',
                up = '<leader>mn',

                -- In Normal Mode
                line_left = '<leader>mh',
                line_right = '<leader>ml',
                line_down = '<leader>mj',
                line_up = '<leader>mk',
            },
        })
        require('mini.sessions').setup({
            autoread = false,
            autowrite = true,
            verbose = {
                read = true,
                write = true,
                delete = true,
            },
        })
        require('mini.splitjoin').setup({})
        require('mini.comment').setup({})
    end,
}

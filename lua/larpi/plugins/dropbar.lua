return {
    'Bekaboo/dropbar.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
    },
    keys = {
        {
            '<leader>;',
            function()
                require('dropbar.api').pick()
            end,
            desc = '[Dropbar] Pick symbols',
        },
        {
            '<leader>[;',
            function()
                require('dropbar.api').goto_context_start()
            end,
            desc = '[Dropbar] Go to start of current context',
        },
        {
            '<leader>];',
            function()
                require('dropbar.api').select_next_context()
            end,
            desc = '[Dropbar] Select next context',
        },
    },
}

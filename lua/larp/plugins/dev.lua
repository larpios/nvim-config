return {

    {
        'stevearc/overseer.nvim',
        opts = {},
        config = function()
            require('overseer').setup({
                templates = {
                    'builtin',
                    'user.cpp_build',
                },
            })
        end,
    },
    {
        'mfussenegger/nvim-dap',
    },
    {
        -- 1. Highlights TODO, FIXME, etc. in your code
        -- 2. Provides a list of all the highlights in your project
        'folke/todo-comments.nvim',
        event = 'BufRead',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {

            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        config = function()
            require('todo-comments').setup({})
            larp.fn.map('n', ']t', function()
                require('todo-comments').jump_next()
            end, { desc = 'Next todo comment' })
            larp.fn.map('n', '[t', function()
                require('todo-comments').jump_prev()
            end, { desc = 'Previous todo comment' })
            -- You can also specify a list of valid jump keywords
            larp.fn.map('n', ']t', function()
                require('todo-comments').jump_next({ keywords = { 'ERROR', 'WARNING' } })
            end, { desc = 'Next error/warning todo comment' })
        end,
    },
    {
        'luckasRanarison/nvim-devdocs',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {},
    },
    {
        'michaelb/sniprun',
        build = 'sh ./install.sh 1',
    },
    {
        'chipsenkbeil/distant.nvim',
        branch = 'v0.3',
        config = function()
            require('distant'):setup()
        end,
    },
    {
        'topaxi/gh-actions.nvim',
        keys = {
            { '<leader>gh', '<cmd>GhActions<cr>', desc = 'Open Github Actions' },
        },
        -- optional, you can also install and use `yq` instead.
        build = 'make',
        ---@type GhActionsConfig
        opts = {},
    },
}

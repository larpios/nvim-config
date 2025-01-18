return {
    {
        'folke/lazydev.nvim',
        ft = 'lua', -- only load on lua files
        opts = {
            library = {
                -- See the configuration section for more details
                -- Load luvit types when the `vim.uv` word is found
                { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
            },
        },
    },
    {
        'stevearc/overseer.nvim',
        dependencies = {
            'akinsho/toggleterm.nvim',
            -- 'rmagatti/auto-session',
        },
        config = function()
            require('custom.overseer')
        end,
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
            },
            {
                'nvim-treesitter/nvim-treesitter',
                build = ':TSUpdate',
            },
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function()
            require('custom.nvim-dap')
        end,
    },
    {
        -- 1. Highlights TODO, FIXME, etc. in your code
        -- 2. Provides a list of all the highlights in your project
        'folke/todo-comments.nvim',
        event = 'BufRead',
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('custom.todo-comments')
        end,
    },
}

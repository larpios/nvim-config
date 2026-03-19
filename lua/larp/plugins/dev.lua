return {
    {
        'stevearc/overseer.nvim',
        cmds = {
            'Overseer',
            'OverseerRun',
            'OverseerRunCmd',
            'OverseerToggle',
            'OverseerBuild',
            'OverseerTaskAction',
            'OverseerClose',
            'OverseerClearCache',
            'OverseerDeleteBundle',
            'OverseerLoadBundle',
            'OverseerInfo',
        },
        keys = {
            { '<leader>cor', '<cmd>OverseerRun<cr>', desc = 'Overseer Run' },
            { '<leader>coR', '<cmd>OverseerRunCmd<cr>', desc = 'Overseer Run Cmd' },
            { '<leader>coa', '<cmd>OverseerTaskAction<cr>', desc = 'Overseer Task Actions' },
            { '<leader>cob', '<cmd>OverseerBuild<cr>', desc = 'Overseer Build' },
            { '<leader>cot', '<cmd>OverseerToggle<cr>', desc = 'Toggle Overseer' },
        },
        dependencies = {
            'akinsho/toggleterm.nvim',
            -- 'rmagatti/auto-session',
        },
        config = function()
            require('overseer').setup({
                dap = false,
                templates = {
                    'builtin',
                    'larp.cpp',
                },
                strategy = 'toggleterm',
            })
        end,
    },
    {
        'folke/todo-comments.nvim',
        event = 'BufRead',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
    },
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
}

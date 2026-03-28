return {
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
    opts = {
        dap = true,
        templates = {
            'builtin',
            'larp.cpp',
        },
    },
}

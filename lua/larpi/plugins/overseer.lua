return {
    'stevearc/overseer.nvim',
    cmds = {
        'OverseerRun',
        'OverseerOpen',
        'OverseerShell',
        'OverseerToggle',
        'OverseerTaskAction',
        'OverseerClose',
    },
    keys = {
        { '<leader>cor', '<Cmd>OverseerRun<CR>', desc = '[Overseer] Run' },
        { '<leader>cos', '<Cmd>OverseerShell<CR>', desc = '[Overseer] Shell' },
        { '<leader>coo', '<Cmd>OverseerOpen<CR>', desc = '[Overseer] Open' },
        { '<leader>coa', '<Cmd>OverseerTaskAction<CR>', desc = '[Overseer] Task Actions' },
        { '<leader>cot', '<Cmd>OverseerToggle<CR>', desc = '[Overseer] Toggle' },
        { '<leader>coc', '<Cmd>OverseerClose<CR>', desc = '[Overseer] Close' },
    },
    opts = {
        dap = true,
        templates = {
            'builtin',
            'larp.cpp',
        },
    },
}

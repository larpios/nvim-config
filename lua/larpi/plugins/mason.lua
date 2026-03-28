return {
    'mason-org/mason.nvim',
    opts = {},
    cmds = {
        'Mason',
        'MasonInstall',
        'MasonLog',
        'MasonUninstall',
        'MasonUninstallAll',
        'MasonUpdate',
    },
    keys = {
        { '<leader>mm', '<cmd>Mason<cr>', desc = '[Mason] Open Mason', silent = true },
    },
}

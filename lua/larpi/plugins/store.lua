return {
    -- Awesome Neovim plugin list
    'alex-popov-tech/store.nvim',
    cmd = 'Store',
    keys = {
        { '<leader>ps', '<cmd>Store<cr>', desc = '[Store] Open Plugin Store' },
    },
    opts = {
        telemetry = false,
    },
}

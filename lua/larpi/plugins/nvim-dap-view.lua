return {
    'igorlfs/nvim-dap-view',
    dependencies = {
        'mfussenegger/nvim-dap',
    },
    -- let the plugin lazy load itself
    lazy = false,
    ---@module 'dap-view'
    ---@type dapview.Config
    opts = {},
}

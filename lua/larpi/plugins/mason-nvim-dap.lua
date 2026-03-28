return {
    'jay-babu/mason-nvim-dap.nvim',
    event = 'VeryLazy',
    dependencies = {
        'mason-org/mason.nvim',
        'mfussenegger/nvim-dap',
    },
    opts = {
        ensure_installed = {
            'codelldb',
            'python',
            'bash',
        },
        handlers = {
            function(config)
                require('mason-nvim-dap').default_setup(config)
            end,
        },
    },
}

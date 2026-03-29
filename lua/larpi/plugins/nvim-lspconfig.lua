return {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        {
            'mason-org/mason.nvim',
            opts = {},
            cmd = {
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
        },
        {
            'mason-org/mason-lspconfig.nvim',
            opts = {
                ensure_installed = {
                    'vimls',
                    'lua_ls',
                    'rust_analyzer',
                    'clangd',
                },
            },
            dependencies = {
                'mason-org/mason.nvim',
                'neovim/nvim-lspconfig',
            },
        },
    },
}

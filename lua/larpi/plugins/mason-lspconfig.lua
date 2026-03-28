return {
    'mason-org/mason-lspconfig.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
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
}

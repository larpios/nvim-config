return {
  'williamboman/mason.nvim',
  dependencies = {
    'williamboman/mason-lspconfig.nvim',
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup {
      ensure_installed = {
        'html',
        'cssls',
        'jsonls',
        'yamlls',
        'tsserver',
        'bashls',
        'pylsp',
        'pylyzer',
        'pyright',
        'rust_analyzer',
        'clangd',
        'cmake',
        'kotlin_language_server',
        'vimls',
        'marksman',
        'graphql',
        'lua_ls',
      },
    }
  end,
}

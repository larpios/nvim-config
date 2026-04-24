-- Small LSP setup
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        focusable = false,
        style = 'minimal',
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.lsp.inlay_hint.enable()

vim.lsp.codelens.enable()

vim.lsp.enable('fish_lsp')

-- Nix LSP
vim.lsp.enable('nil_ls')

-- Nushell LSP
vim.lsp.enable('nushell')

vim.lsp.enable('bpls')
vim.lsp.config('bpls', {
    cmd = { 'bpls' },
    filetypes = { 'bp' },
})

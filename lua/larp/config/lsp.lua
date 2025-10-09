
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

vim.lsp.enable('fish_lsp')
vim.lsp.enable('bpls')
vim.lsp.config('bpls', {
    cmd = { 'bpls' },
    filetypes = { 'bp' },
})

if package.loaded['rustaceanvim'] then
    local bufnr = vim.api.nvim_get_current_buf()
    vim.keymap.set('n', 'gra', function()
        vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
    end, { desc = '[Rustaceanvim] Code Action', buffer = bufnr })
    vim.keymap.set(
        'n',
        'K', -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
        function()
            vim.cmd.RustLsp({ 'hover', 'actions' })
        end,
        { desc = '[Rustaceanvim] Hover', buffer = bufnr }
    )
end

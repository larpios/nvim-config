vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
    desc = 'Hightlight selection on yank',
    pattern = '*',
    callback = function()
        vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 200 })
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp_attach', {}),
    desc = 'Attach LSP',
    pattern = '*',
    callback = function()
        larp.fn.map('', 'gh', function()
            vim.diagnostic.open_float({
                source = true,
                format = function(diagnostic)
                    return string.format('%s [%s]', diagnostic.message, diagnostic.source)
                end,
                border = 'rounded',
                severity_sort = true,
                focus_id = 'diagnostic',
            })
        end, { desc = 'Get diagnostics' })

        larp.fn.map('', '<leader>cr', function()
            vim.lsp.buf.rename()
        end)
    end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('keymap_read', {}),
    desc = 'Recognize *.keymap files as C files',
    pattern = '*.keymap',
    callback = function()
        vim.cmd([[set filetype=c]])
    end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    group = vim.api.nvim_create_augroup('keymap_read', {}),
    desc = 'Recognize *.keymap files as C files',
    pattern = { '*.markdown', '*.md', '*.norg' },
    callback = function()
        local marks = {
            { symbol = '*', key = 'b', name = 'Bold' },
            { symbol = '/', key = 'i', name = 'Italics' },
            { symbol = '_', key = 't', name = 'Strikethrough' },
            { symbol = '`', key = 'c', name = 'Inline Code' },
            { symbol = '^', key = '6', name = 'Superscript' },
            { symbol = ',', key = ',', name = 'Subscript' },
            { symbol = '$', key = 'm', name = 'Math' },
            { symbol = '&', key = 'v', name = 'Variable' },
            { symbol = '%', key = '3', name = 'Inline Comment' },
        }

        for _, m in ipairs(marks) do
            larp.fn.map('x', '<C-' .. m.key .. '>', function()
                larp.fn.toggle_marker(m.symbol)
            end, { desc = 'Toggle ' .. m.name })
        end
    end,
})

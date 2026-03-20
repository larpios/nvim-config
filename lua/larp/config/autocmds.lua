vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {}),
    desc = 'Hightlight selection on yank',
    pattern = '*',
    callback = function()
        vim.hl.on_yank({ higroup = 'IncSearch', timeout = 200 })
    end,
})

vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('lsp_attach', {}),
    desc = 'Attach LSP',
    pattern = '*',
    callback = function()
        vim.keymap.set('', 'gh', function()
            vim.diagnostic.open_float({
                source = true,
                format = function(diagnostic)
                    return string.format('%s [%s]', diagnostic.message, diagnostic.source)
                end,
                border = 'rounded',
                severity_sort = true,
                focus_id = 'diagnostic',
                focusable = true,
            })
        end, { desc = 'Get diagnostics' })

        vim.keymap.set('', 'gd', function()
            vim.lsp.buf.definition()
        end, { desc = 'Go to Definition' })
        vim.keymap.set('', 'gD', function()
            vim.lsp.buf.type_definition()
        end, { desc = 'Go to Type Definition' })

        vim.keymap.set('', '<leader>ca', function()
            vim.lsp.buf.code_action()
        end)
        vim.keymap.set('', '<leader>cf', function()
            vim.lsp.buf.format({ async = true })
        end)

        -- vim.lsp.inlay_hint.enable(true, { bufnr = 0 })
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
    group = vim.api.nvim_create_augroup('MarkdownRead', {}),
    desc = 'Add useful keymaps for markdown files',
    pattern = { '*.markdown', '*.md', '*.txt' },
    callback = function()
        local get_selection_range = function()
            local pos1 = vim.list_slice(vim.fn.getpos('v'), 2, 3)
            local pos2 = vim.list_slice(vim.fn.getpos('.'), 2, 3)
            local start_tbl, end_tbl
            if pos1[1] < pos2[1] or (pos1[1] == pos2[1] and pos1[2] <= pos2[2]) then
                start_tbl = pos1
                end_tbl = pos2
            else
                start_tbl = pos2
                end_tbl = pos1
            end
            if vim.fn.mode() == 'V' then
                start_tbl[2] = 1
            end

            -- Append end_tbl to start_tbl
            for _, val in ipairs(end_tbl) do
                table.insert(start_tbl, val)
            end

            return start_tbl
        end

        local toggle_marker = function(sym)
            -- Get the current mode
            local mode = vim.api.nvim_get_mode().mode

            -- Check if we're in any visual mode
            if not (mode:sub(1, 1) == 'v' or mode:sub(1, 1) == 'V' or mode:sub(1, 1) == '\22') then
                return
            end

            -- Get the visual selection range
            local start_row, start_col, end_row, end_col = unpack(get_selection_range())

            -- Check if the entire selection is wrapped with the marker
            local first_char = vim.api.nvim_buf_get_text(0, start_row - 1, start_col - 1, start_row - 1, start_col - 1 + #sym, {})[1]
            local last_char = vim.api.nvim_buf_get_text(0, end_row - 1, end_col - #sym, end_row - 1, end_col, {})[1]

            local need_remove = first_char == last_char and first_char == sym

            if need_remove then
                -- Remove markers
                vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, start_row - 1, start_col + #sym - 1, { '' })
                if start_row == end_row then
                    end_col = end_col - #sym
                end
                vim.api.nvim_buf_set_text(0, end_row - 1, end_col - #sym, end_row - 1, end_col, { '' })
                end_col = end_col - #sym
            else
                -- Add markers
                vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, start_row - 1, start_col - 1, { sym })
                if start_row == end_row then
                    end_col = end_col + #sym
                end
                vim.api.nvim_buf_set_text(0, end_row - 1, end_col, end_row - 1, end_col, { sym })
                end_col = end_col + 1
            end

            -- Reselect the modified text
            local compensate = need_remove and 0 or (#sym - 1)
            vim.api.nvim_win_set_cursor(0, { start_row, start_col - 1 })
            vim.cmd('normal! \27')
            vim.cmd('normal! ' .. mode)
            vim.api.nvim_win_set_cursor(0, { end_row, end_col - 1 + compensate })
        end

        local marks = {
            { symbol = '**', key = 'b', name = 'Bold' },
            { symbol = '_', key = 'i', name = 'Italics' },
            { symbol = '~~', key = 't', name = 'Strikethrough' },
            { symbol = '`', key = 'c', name = 'Inline Code' },
            { symbol = '$', key = 'm', name = 'Math' },
        }

        for _, m in ipairs(marks) do
            vim.keymap.set('x', '<C-' .. m.key .. '>', function()
                toggle_marker(m.symbol)
            end, { desc = 'Toggle ' .. m.name })
        end

        ------------------

        -- Enable spell check for English
        --
        vim.o.spell = true
        vim.o.spelllang = 'en_us'
        vim.notify('Spell check enabled for English')
    end,
})

-- When a help window opens, force it to move to the right
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('help_window', {}),
    desc = 'Move help window to the right',
    pattern = 'help',
    callback = function()
        vim.cmd('wincmd L')
    end,
})

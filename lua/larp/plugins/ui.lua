return function(load, on_event, on_ft, lazy_cmd, later)
    -- BufWinEnter: UI infrastructure
    on_event('BufWinEnter', { 'bufferline.nvim', 'nvim-web-devicons' }, function()
        require('bufferline').setup({})
        vim.keymap.set('n', 'L', '<cmd>BufferLineCycleNext<cr>',  { desc = 'Next Buffer' })
        vim.keymap.set('n', 'H', '<cmd>BufferLineCyclePrev<cr>',  { desc = 'Previous Buffer' })
        vim.keymap.set('n', '<leader>>', '<cmd>BufferLineMoveNext<cr>', { desc = 'Move Buffer Right' })
        vim.keymap.set('n', '<leader><', '<cmd>BufferLineMovePrev<cr>', { desc = 'Move Buffer Left' })
        vim.keymap.set('n', '<leader>bc', '<cmd>BufferLinePickClose<cr>', { desc = 'Close buffer' })
        vim.keymap.set('n', '<leader>bp', '<cmd>BufferLinePick<cr>',     { desc = 'Pick Buffer' })
        vim.keymap.set('n', '<leader>br', '<cmd>BufferLineTabRename<cr>', { desc = 'Rename Tab' })
    end)

    on_event('BufWinEnter', { 'lualine.nvim', 'nvim-web-devicons', 'overseer.nvim' }, function()
        require('custom.lualine')
    end)

    -- Deferred UI (VeryLazy)
    later(function()
        load({ 'noice.nvim', 'nui.nvim', 'nvim-notify' }, function()
            require('custom.noice')
        end)
        load({ 'dressing.nvim' }, function()
            require('dressing').setup({})
        end)
        load({ 'fidget.nvim' }, function()
            require('fidget').setup({})
        end)
        load({ 'colorful-winsep.nvim' }, function()
            require('colorful-winsep').setup({})
        end)
        load({ 'modicator.nvim' }, function()
            require('modicator').setup({})
        end)
    end)

    -- Command stubs
    lazy_cmd({ 'ShowkeysToggle' }, { 'showkeys' }, function()
        require('showkeys').setup({
            maxkeys  = 5,
            winopts  = { focusable = true },
            show_count = true,
            position = 'top-right',
        })
    end)

    lazy_cmd({ 'CccConvert', 'CccPick', 'CccHighlighterDisable', 'CccHighlighterEnable', 'CccHighlighterToggle' },
        { 'ccc.nvim' }, function()
            require('custom.ccc')
        end)
end

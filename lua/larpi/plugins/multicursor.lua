return {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    keys = {
        {
            '<leader><leader>k',
            function()
                require('multicursor-nvim').lineAddCursor(-1)
            end,
            mode = { 'n', 'x' },
            desc = '[Multicursor] Add cursor above',
        },
        {
            '<leader><leader>j',
            function()
                require('multicursor-nvim').lineAddCursor(1)
            end,
            mode = { 'n', 'x' },
            desc = '[Multicursor] Add cursor below',
        },
        {
            '<C-k>',
            function()
                require('multicursor-nvim').lineAddCursor(-1)
            end,
            mode = { 'i', 'x' },
            desc = '[Multicursor] Add cursor above',
        },
        {
            '<C-j>',
            function()
                require('multicursor-nvim').lineAddCursor(1)
            end,
            mode = { 'i', 'x' },
            desc = '[Multicursor] Add cursor below',
        },
        {
            '<leader><up>',
            function()
                require('multicursor-nvim').lineSkipCursor(-1)
            end,
            mode = { 'n', 'x' },
            desc = '[Multicursor] Skip cursor above',
        },
        {
            '<leader><down>',
            function()
                require('multicursor-nvim').lineSkipCursor(1)
            end,
            mode = { 'n', 'x' },
            desc = '[Multicursor] Skip cursor below',
        },

        -- Add or skip adding a new cursor by matching word/selection
        {
            '<leader><leader>n',
            function()
                require('multicursor-nvim').matchAddCursor(1)
            end,
            mode = { 'n', 'x' },
            desc = '[Multicursor] Add Cursor to Next Match',
        },
        {
            '<leader><leader>s',
            function()
                require('multicursor-nvim').matchSkipCursor(1)
            end,
            mode = { 'n', 'x' },
            desc = '[Multicursor] Skip Cursor to Next Match',
        },
        {
            '<leader><leader>N',
            function()
                require('multicursor-nvim').matchAddCursor(-1)
            end,
            mode = { 'n', 'x' },
            desc = '[Multicursor] Add Cursor to Previous Match',
        },
        {
            '<leader><leader>S',
            function()
                require('multicursor-nvim').matchSkipCursor(-1)
            end,
            mode = { 'n', 'x' },
            desc = '[Multicursor] Skip Cursor to Previous Match',
        },

        -- Add and remove cursors with control + left click.
        {
            '<c-leftmouse>',
            function()
                require('multicursor-nvim').handleMouse()
            end,
            mode = 'n',
            desc = '[Multicursor] Add Cursor at Mouse',
        },
        {
            '<c-leftdrag>',
            function()
                require('multicursor-nvim').handleMouseDrag()
            end,
            mode = 'n',
            desc = '[Multicursor] Add Cursor at Mouse',
        },
        {
            '<c-leftrelease>',
            function()
                require('multicursor-nvim').handleMouseRelease()
            end,
            mode = 'n',
            desc = '[Multicursor] Add Cursor at Mouse',
        },

        -- Disable and enable cursors.
        {
            '<c-q>',
            function()
                require('multicursor-nvim').toggleCursor()
            end,
            mode = { 'n', 'x' },
            desc = '[Multicursor] Toggle Cursors',
        },
    },
    init = function()
        -- Customize how cursors look.
        vim.api.nvim_set_hl(0, 'MultiCursorCursor', { reverse = true })
        vim.api.nvim_set_hl(0, 'MultiCursorVisual', { link = 'Visual' })
        vim.api.nvim_set_hl(0, 'MultiCursorSign', { link = 'SignColumn' })
        vim.api.nvim_set_hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
        vim.api.nvim_set_hl(0, 'MultiCursorDisabledCursor', { reverse = true })
        vim.api.nvim_set_hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
        vim.api.nvim_set_hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
    end,
    opts = {},
    config = function(_, opts)
        local mc = require('multicursor-nvim')
        mc.setup(opts)

        -- Mappings defined in a keymap layer only apply when there are
        -- multiple cursors. This lets you have overlapping mappings.
        mc.addKeymapLayer(function(layerSet)
            -- Select a different cursor as the main one.
            layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
            layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)

            -- Delete the main cursor.
            layerSet({ 'n', 'x' }, '<leader>x', mc.deleteCursor)

            -- Enable and clear cursors using escape.
            layerSet('n', '<esc>', function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)
    end,
}

return {
    {
        'chrisgrieser/nvim-rip-substitute',
        cmd = 'RipSubstitute',
        keys = {
            {
                '<leader>rr',
                function()
                    require('rip-substitute').sub()
                end,
                mode = { 'n', 'x' },
                desc = ' rip substitute',
            },
        },
        opts = {},
    },
    {
        'smjonas/live-command.nvim',
        cmd = { 'Norm', 'Preview' },
        opts = {
            enable_highlighting = true,
            inline_highlighting = true,
            commands = {
                Norm = { cmd = 'norm' },
            },
        },
    },
    {
        'chrisgrieser/nvim-scissors',
        dependencies = { 'folke/snacks.nvim' },
        opts = {
            snippetDir = vim.fn.stdpath('config') .. '/snippets',
        },
        cmd = {
            'ScissorsAddNewSnippet',
            'ScissorsEditSnippet',
        },
        keys = {
            {
                '<leader>Se',
                function()
                    require('scissors').editSnippet()
                end,
                mode = { 'n' },
                desc = '[Scissors]  edit snippet',
            },
            {
                '<leader>Sa',
                function()
                    require('scissors').addNewSnippet()
                end,
                mode = { 'n', 'x' },
                desc = '[Scissors]  add new snippet',
            },
        },
    },

    {
        -- Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
        'chrisgrieser/nvim-spider',
        config = true,
        event = 'BufReadPost',
        keys = {
            {
                'w',
                function()
                    require('spider').motion('w')
                end,
                mode = { 'n', 'o', 'x' },
                desc = 'Spider-w',
            },
            {
                'e',
                function()
                    require('spider').motion('e')
                end,
                mode = { 'n', 'o', 'x' },
                desc = 'Spider-e',
            },
            {
                'b',
                function()
                    require('spider').motion('b')
                end,
                mode = { 'n', 'o', 'x' },
                desc = 'Spider-b',
            },
            {
                '<C-f>',
                function()
                    vim.cmd('norm l')
                    require('spider').motion('w')
                end,
                mode = 'i',
                desc = '[Spider] Move Forward Word',
            },
            {
                '<C-b>',
                function()
                    require('spider').motion('b')
                end,
                mode = 'i',
            },
        },
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        event = { 'BufReadPre', 'BufNewFile' },
        init = function()
            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = 'rainbow-delimiters.strategy.global',
                },
                query = {
                    [''] = 'rainbow-delimiters',
                },
                condition = function(bufnr)
                    local ft = vim.bo[bufnr].filetype
                    if ft == '' then
                        return false
                    end
                    local lang = vim.treesitter.language.get_lang(ft)
                    if not lang then
                        return false
                    end
                    local ok, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
                    return ok and parser ~= nil
                end,
                blacklist = {
                    'oil',
                    'noice',
                    'notify',
                    'lazy',
                    'mason',
                    'Trouble',
                    'alpha',
                    'dashboard',
                    'neo-tree',
                    'NvimTree',
                    'fidget',
                    'snacks_notif',
                    'snacks_notif_history',
                    'snacks_terminal',
                    'snacks_win',
                    'snacks_input',
                    'snacks_picker_input',
                    'snacks_picker_preview',
                    'snacks_layout',
                    'blink-cmp-menu',
                    'blink-cmp-signature-help',
                    'blink-cmp-documentation',
                },
            }
        end,
    },
    {
        'ibhagwan/smartyank.nvim',
        event = 'VeryLazy',
        opts = {
            highlight = {
                enabled = true,
                higroup = 'IncSearch',
                timeout = 200,
            },
            clipboard = {
                enabled = false,
            },
            osc52 = {
                enabled = true,
                ssh_only = true,
                silent = false,
            },
        },
    },
    {
        'jiaoshijie/undotree',
        ---@module 'undotree.collector'
        ---@type UndoTreeCollector.Opts
        opts = {},
        keys = { -- load the plugin only when using it's keybinding:
            {
                '<leader>tu',
                function()
                    require('undotree').toggle()
                end,
                desc = '[UndoTree] Toggle',
            },
        },
    },
    {
        -- Enhance the usage of macros in Neovim
        'chrisgrieser/nvim-recorder',
        event = 'VeryLazy',
        opts = {
            mapping = {
                startStopRecording = '<leader>q',
                playMacro = '<leader>Q',
                switchSlot = '<leader>mn',
                editMacro = '<leader>me',
                deleteAllMacros = '<leader>md',
                yankMacro = '<leader>my',
                -- ⚠️ this should be a string you don't use in insert mode during a macro
                addBreakPoint = '##',
            },
        }, -- required even with default settings, since it calls `setup()`
    },
    {
        'jake-stewart/multicursor.nvim',
        branch = '1.0',
        keys = {
            {
                '<up>',
                function()
                    require('multicursor-nvim').lineAddCursor(-1)
                end,
                mode = { 'n', 'x' },
                desc = '[Multicursor] Add cursor above',
            },
            {
                '<down>',
                function()
                    require('multicursor-nvim').lineAddCursor(1)
                end,
                mode = { 'n', 'x' },
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
                '<leader>n',
                function()
                    require('multicursor-nvim').matchAddCursor(1)
                end,
                mode = { 'n', 'x' },
                desc = '[Multicursor] Add Cursor to Next Match',
            },
            {
                '<leader>s',
                function()
                    require('multicursor-nvim').matchSkipCursor(1)
                end,
                mode = { 'n', 'x' },
                desc = '[Multicursor] Skip Cursor to Next Match',
            },
            {
                '<leader>N',
                function()
                    require('multicursor-nvim').matchAddCursor(-1)
                end,
                mode = { 'n', 'x' },
                desc = '[Multicursor] Add Cursor to Previous Match',
            },
            {
                '<leader>S',
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
    },
}

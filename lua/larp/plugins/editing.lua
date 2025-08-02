return {
    -- {
    --     'numToStr/Comment.nvim',
    --     opts = {},
    --     lazy = false,
    -- },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
        config = function()
            require('custom.indent-blankline')
        end,
    },
    {
        'chrisgrieser/nvim-rip-substitute',
        cmd = 'RipSubstitute',
        keys = {
            {
                '<leader>Ss',
                function()
                    require('rip-substitute').sub()
                end,
                mode = { 'n', 'x' },
            },
        },
        opts = {},
    },
    {
        'cshuaimin/ssr.nvim',
        module = 'ssr',
        -- Calling setup is optional.

        config = function()
            require('custom.ssr')
        end,
    },
    {
        'smjonas/live-command.nvim',
        -- live-command supports semantic versioning via Git tags
        -- tag = "2.*",
        config = function()
            require('live-command').setup({
                commands = {
                    Norm = { cmd = 'norm' },
                },
            })
        end,
    },
    -- lazy.nvim
    {
        'chrisgrieser/nvim-rip-substitute',
        cmd = 'RipSubstitute',
        keys = {
            {
                '<leader>fs',
                function()
                    require('rip-substitute').sub()
                end,
                mode = { 'n', 'x' },
                desc = ' rip substitute',
            },
        },
    },
    -- {
    --     'jake-stewart/multicursor.nvim',
    --     branch = '1.0',
    --     config = function()
    --         require('custom.multicursor')
    --     end,
    -- },
    -- {
    --     'gennaro-tedesco/nvim-peekup',
    -- },
    -- lazy.nvim
    {
        'chrisgrieser/nvim-scissors',
        dependencies = { 'nvim-telescope/telescope.nvim', 'garymjr/nvim-snippets' },
        opts = {
            snippetDir = vim.fn.stdpath('config') .. '/snippets',
        },
        keys = {
            {
                '<leader>se',
                function()
                    require('scissors').editSnippet()
                end,
                mode = { 'n' },
                desc = ' edit snippet',
            },
            {
                '<leader>sa',
                function()
                    require('scissors').addNewSnippet()
                end,
                mode = { 'n', 'x' },
                desc = ' add new snippet',
            },
        },
    },

    {
        -- Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
        'chrisgrieser/nvim-spider',
        event = 'BufRead',
        config = function()
            require('custom.nvim-spider')
        end,
    },
    -- {
    --     'willothy/flatten.nvim',
    --     config = true,
    --     -- or pass configuration with
    --     -- opts = {  }
    --     -- Ensure that it runs first to minimize delay when opening file from terminal
    --     lazy = false,
    --     priority = 1001,
    -- },
    {
        'HiPhish/rainbow-delimiters.nvim',
    },
    {
        'AckslD/nvim-neoclip.lua',
        dependencies = {
            -- {'nvim-telescope/telescope.nvim'},
            { 'ibhagwan/fzf-lua' },
        },
        config = function()
            require('custom.nvim-neoclip')
        end,
    },
    {
        'LintaoAmons/scratch.nvim',
        event = 'VeryLazy',
    },
    {
        'ibhagwan/smartyank.nvim',
        opts = {
            highlight = {
                enabled = true,
                higroup = 'IncSearch',
                timeout = 200,
            },
            osc52 = {
                enabled = true,
                ssh_only = true,
                silent = false,
            },
            clipboard = {
                enabled = false,
            },
        },
    },
    {
        'jake-stewart/multicursor.nvim',
        branch = '1.0',
        config = function()
            local mc = require('multicursor-nvim')
            mc.setup()

            local set = vim.keymap.set

            -- Add or skip cursor above/below the main cursor.
            set({ 'n', 'x' }, '<up>', function()
                mc.lineAddCursor(-1)
            end)
            set({ 'n', 'x' }, '<down>', function()
                mc.lineAddCursor(1)
            end)
            set({ 'n', 'x' }, '<leader><up>', function()
                mc.lineSkipCursor(-1)
            end)
            set({ 'n', 'x' }, '<leader><down>', function()
                mc.lineSkipCursor(1)
            end)

            -- Add or skip adding a new cursor by matching word/selection
            set({ 'n', 'x' }, '<leader>n', function()
                mc.matchAddCursor(1)
            end)
            set({ 'n', 'x' }, '<leader>s', function()
                mc.matchSkipCursor(1)
            end)
            set({ 'n', 'x' }, '<leader>N', function()
                mc.matchAddCursor(-1)
            end)
            set({ 'n', 'x' }, '<leader>S', function()
                mc.matchSkipCursor(-1)
            end)

            -- Add and remove cursors with control + left click.
            set('n', '<c-leftmouse>', mc.handleMouse)
            set('n', '<c-leftdrag>', mc.handleMouseDrag)
            set('n', '<c-leftrelease>', mc.handleMouseRelease)

            -- Disable and enable cursors.
            set({ 'n', 'x' }, '<c-q>', mc.toggleCursor)

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

            -- Customize how cursors look.
            local hl = vim.api.nvim_set_hl
            hl(0, 'MultiCursorCursor', { reverse = true })
            hl(0, 'MultiCursorVisual', { link = 'Visual' })
            hl(0, 'MultiCursorSign', { link = 'SignColumn' })
            hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
            hl(0, 'MultiCursorDisabledCursor', { reverse = true })
            hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
            hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
        end,
    },
}

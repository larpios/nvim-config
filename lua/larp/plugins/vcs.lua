return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        config = function()
            require('gitsigns').setup({
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        vim.keymap.set(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']c', bang = true })
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end, { desc = 'Go to Next Hunk' })

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[c', bang = true })
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end, { desc = 'Go to Previous Hunk' })

                    -- Actions
                    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage Hunk' })
                    map('n', '<leader>hr', gitsigns.reset_hunk)
                    map('v', '<leader>hs', function()
                        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end, { desc = 'Stage Hunk' })
                    map('v', '<leader>hr', function()
                        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end)
                    map('n', '<leader>hS', gitsigns.stage_buffer)
                    map('n', '<leader>hu', gitsigns.undo_stage_hunk)
                    map('n', '<leader>hR', gitsigns.reset_buffer)
                    map('n', '<leader>hp', gitsigns.preview_hunk)
                    map('n', '<leader>hb', function()
                        gitsigns.blame_line({ full = true })
                    end)
                    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                    map('n', '<leader>hd', gitsigns.diffthis)
                    map('n', '<leader>hD', function()
                        gitsigns.diffthis('~')
                    end)
                    map('n', '<leader>td', gitsigns.toggle_deleted)

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end,
            })
        end,
    },
    {
        'esmuellert/codediff.nvim',
        cmd = { 'CodeDiff', 'VscodeDiff' },
    },
    {
        -- Visualize git conflicts
        'akinsho/git-conflict.nvim',
        version = '*',
        config = true,
        event = 'BufRead',
    },
    {
        'nicolasgb/jj.nvim',
        version = '*', -- Use latest stable release
        event = 'VeryLazy',
        dependencies = {
            'esmuellert/codediff.nvim',
            'folke/snacks.nvim',
        },
        opts = {
            terminal = {
                cursor_render_delay = 10, -- Adjust if cursor position isn't restoring correctly
            },
            diff = {
                backend = "codediff"
            },
        },
        keys = {
            {
                '<leader>jl',
                function()
                    require('jj.cmd').log()
                end,
                desc = '[JJ] Log'
            },
            {
                '<leader>jL',
                function()
                    require('jj.cmd').log({
                        revisions = '::',
                    })
                end,
                desc = '[JJ] Log All'
            },
            {
                -- Alias for moving bookmarks
                '<leader>jt',
                function()
                    require('jj.cmd').j('tug')
                    require('jj.cmd').log()
                end,
                desc = '[JJ] Tug'
            },
            {
                '<leader>jc',
                function()
                    require('jj.cmd').commit()
                end,
                desc = '[JJ] Commit'
            },
            {
                '<leader>jD',
                function()
                    require('jj.cmd').describe()
                end,
                desc = '[JJ] Describe'
            },
            {
                '<leader>je',
                function()
                    require('jj.cmd').edit()
                end,
                desc = '[JJ] Edit'
            },
            {
                '<leader>jn',
                function()
                    require('jj.cmd').new()
                end,
                desc = '[JJ] New'
            },
            {
                '<leader>jsh',
                function()
                    require('jj.cmd').j('show')
                end,
                desc = '[JJ] Show'
            },
            {
                '<leader>jst',
                function()
                    require('jj.cmd').status()
                end,
                desc = '[JJ] Status'
            },
            {
                '<leader>jsp',
                function()
                    require('jj.cmd').split()
                end,
                desc = '[JJ] Split'
            },
            {
                '<leader>jsq',
                function()
                    require('jj.cmd').squash()
                end,
                desc = '[JJ] Squash'
            },
            {
                '<leader>jou',
                function()
                    require('jj.cmd').undo()
                end,
                desc = '[JJ] Undo Operation'
            },
            {
                '<leader>jor',
                function()
                    require('jj.cmd').redo()
                end,
                desc = '[JJ] Redo Operation'
            },
            {
                '<leader>jbc',
                function()
                    require('jj.cmd').bookmark_create()
                end,
                desc = '[JJ] Create Bookmark'
            },
            {
                '<leader>jbd',
                function()
                    require('jj.cmd').bookmark_delete()
                end,
                desc = '[JJ] Delete Bookmark'
            },
            {
                '<leader>jbm',
                function()
                    require('jj.cmd').bookmark_move()
                end,
                desc = '[JJ] Move Bookmark'
            },
            {
                '<leader>ja',
                function()
                    require('jj.cmd').abandon()
                end,
                desc = '[JJ] Abandon'
            },
            {
                '<leader>jp',
                function()
                    require('jj.cmd').push()
                end,
                desc = '[JJ] Push'
            },
            {
                '<leader>jf',
                function()
                    require('jj.cmd').fetch()
                end,
                desc = '[JJ] Fetch'
            },
            {
                '<leader>jdf',
                function()
                    require('jj.diff').open_vdiff()
                end,
                desc = '[JJ] Open VDiff'
            },
            {
                '<leader>jdF',
                function()
                    require('jj.diff').open_hdiff()
                end,
                desc = '[JJ] Open HDiff'
            },
            {
                '<leader>jps',
                function()
                    require('jj.picker').status()
                end,
                desc = '[JJ] Pick Status'
            },
            {
                '<leader>jph',
                function()
                    require('jj.diff').file_history()
                end,
                desc = '[JJ] Pick File History'
            },
        }
    },
    {
        'NicholasZolton/neojj',
        lazy = true,
        dependencies = {
            'nvim-lua/plenary.nvim', -- required
            'esmuellert/codediff.nvim',
            'folke/snacks.nvim',
        },
        cmd = 'Neojj',
        keys = {
            {
                '<leader>jj',
                function()
                    require('neojj').open()
                end,
                desc = '[Neojj] Show Neojj UI'
            },
            {
                '<leader>jC',
                function()
                    require('neojj').open({ cwd = '~/.config/nvim' })
                end,
                desc = '[Neojj] Open Neovim Config'
            },
        },
    },
    {
        'julienvincent/hunk.nvim',
        cmd = { 'DiffEditor' },
        config = true,
    },
}

return {
    'nicolasgb/jj.nvim',
    version = '*', -- Use latest stable release
    dependencies = {
        'esmuellert/codediff.nvim',
        'folke/snacks.nvim',
    },
    opts = {
        terminal = {
            cursor_render_delay = 10, -- Adjust if cursor position isn't restoring correctly
        },
        diff = {
            backend = 'codediff',
        },
    },
    cmd = 'JJ',
    keys = {
        {
            '<leader>jl',
            function()
                require('jj.cmd').log()
            end,
            desc = '[JJ] Log',
        },
        {
            '<leader>jL',
            function()
                require('jj.cmd').log({
                    revisions = '::',
                })
            end,
            desc = '[JJ] Log All',
        },
        {
            -- Alias for moving bookmarks
            '<leader>jt',
            function()
                require('jj.cmd').j('tug')
                require('jj.cmd').log()
            end,
            desc = '[JJ] Tug',
        },
        {
            '<leader>jC',
            function()
                require('jj.cmd').commit()
            end,
            desc = '[JJ] Commit',
        },
        {
            '<leader>jD',
            function()
                require('jj.cmd').describe()
            end,
            desc = '[JJ] Describe',
        },
        {
            '<leader>je',
            function()
                require('jj.cmd').edit()
            end,
            desc = '[JJ] Edit',
        },
        {
            '<leader>jn',
            function()
                require('jj.cmd').new()
            end,
            desc = '[JJ] New',
        },
        {
            '<leader>jsh',
            function()
                require('jj.cmd').j('show')
            end,
            desc = '[JJ] Show',
        },
        {
            '<leader>jst',
            function()
                require('jj.cmd').status()
            end,
            desc = '[JJ] Status',
        },
        {
            '<leader>jsp',
            function()
                require('jj.cmd').split()
            end,
            desc = '[JJ] Split',
        },
        {
            '<leader>jsq',
            function()
                require('jj.cmd').squash()
            end,
            desc = '[JJ] Squash',
        },
        {
            '<leader>jou',
            function()
                require('jj.cmd').undo()
            end,
            desc = '[JJ] Undo Operation',
        },
        {
            '<leader>jor',
            function()
                require('jj.cmd').redo()
            end,
            desc = '[JJ] Redo Operation',
        },
        {
            '<leader>jbc',
            function()
                require('jj.cmd').bookmark_create()
            end,
            desc = '[JJ] Create Bookmark',
        },
        {
            '<leader>jbd',
            function()
                require('jj.cmd').bookmark_delete()
            end,
            desc = '[JJ] Delete Bookmark',
        },
        {
            '<leader>jbm',
            function()
                require('jj.cmd').bookmark_move()
            end,
            desc = '[JJ] Move Bookmark',
        },
        {
            '<leader>ja',
            function()
                require('jj.cmd').abandon()
            end,
            desc = '[JJ] Abandon',
        },
        {
            '<leader>jp',
            function()
                require('jj.cmd').push()
            end,
            desc = '[JJ] Push',
        },
        {
            '<leader>jf',
            function()
                require('jj.cmd').fetch()
            end,
            desc = '[JJ] Fetch',
        },
        {
            '<leader>jdf',
            function()
                require('jj.diff').open_vdiff()
            end,
            desc = '[JJ] Open VDiff',
        },
        {
            '<leader>jdF',
            function()
                require('jj.diff').open_hdiff()
            end,
            desc = '[JJ] Open HDiff',
        },
        {
            '<leader>jps',
            function()
                require('jj.picker').status()
            end,
            desc = '[JJ] Pick Status',
        },
        {
            '<leader>jph',
            function()
                require('jj.diff').file_history()
            end,
            desc = '[JJ] Pick File History',
        },
    },
}

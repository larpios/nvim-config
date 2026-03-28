return {
    'lewis6991/gitsigns.nvim',
    opts = {},
    event = { 'BufReadPre', 'BufNewFile' },
    keys = {
        {
            ']c',
            function()
                if vim.wo.diff then
                    vim.cmd.normal({ ']c', bang = true })
                else
                    require('gitsigns').nav_hunk('next')
                end
            end,
            desc = '[GitSigns] Go to Next Hunk',
        },
        {
            '[c',
            function()
                if vim.wo.diff then
                    vim.cmd.normal({ '[c', bang = true })
                else
                    require('gitsigns').nav_hunk('prev')
                end
            end,
            mode = 'n',
            desc = '[GitSigns] Go to Previous Hunk',
        },

        -- Actions
        {
            '<leader>hs',
            function()
                require('gitsigns').stage_hunk()
            end,
            mode = 'n',
            desc = '[GitSigns] Stage Hunk',
        },
        {
            '<leader>hr',
            function()
                require('gitsigns').reset_hunk()
            end,
            mode = 'n',
            desc = '[GitSigns] Reset Hunk',
        },
        {
            '<leader>hs',
            function()
                require('gitsigns').stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end,
            mode = 'x',
            desc = '[GitSigns] Stage Hunk',
        },
        {
            '<leader>hr',
            function()
                require('gitsigns').reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
            end,
            mode = 'x',
            desc = '[GitSigns] Reset Hunk',
        },
        {
            mode = 'n',
            '<leader>hS',
            function()
                require('gitsigns').stage_buffer()
            end,
            desc = '[GitSigns] Stage Buffer',
        },
        {
            mode = 'n',
            '<leader>hu',
            function()
                require('gitsigns').undo_stage_hunk()
            end,
            desc = '[GitSigns] Undo Stage Hunk',
        },
        {
            mode = 'n',
            '<leader>hR',
            function()
                require('gitsigns').reset_buffer()
            end,
            desc = '[GitSigns] Reset Buffer',
        },
        {
            mode = 'n',
            '<leader>hp',
            function()
                require('gitsigns').preview_hunk()
            end,
            desc = '[GitSigns] Preview Hunk',
        },
        {
            mode = 'n',
            '<leader>hb',
            function()
                require('gitsigns').blame_line({ full = true })
            end,
            desc = '[GitSigns] Blame Line',
        },
        {
            mode = 'n',
            '<leader>tb',
            function()
                require('gitsigns').toggle_current_line_blame()
            end,
            desc = '[GitSigns] Toggle Blame Line',
        },
        {
            mode = 'n',
            '<leader>hd',
            function()
                require('gitsigns').diffthis()
            end,
            desc = '[GitSigns] Diff This',
        },
        {
            mode = 'n',
            '<leader>hD',
            function()
                require('gitsigns').diffthis('~')
            end,
            desc = '[GitSigns] Diff This ~',
        },
        {
            mode = 'n',
            '<leader>td',
            function()
                require('gitsigns').toggle_deleted()
            end,
            desc = '[GitSigns] Toggle Deleted',
        },

        -- Text object
        {
            'ih',
            function()
                require('gitsigns').select_hunk()
            end,
            mode = { 'o', 'x' },
            desc = '[GitSigns] Select Hunk',
        },
    },
}

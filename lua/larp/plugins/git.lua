return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        config = function()
            require('custom.gitsigns')
        end,
    },
    {
        'sindrets/diffview.nvim',
        event = 'BufRead',
        cmds = {
            'DiffviewOpen',
            'DiffviewClose',
            'DiffviewToggleFiles',
            'DiffviewFocusFiles',
            'DiffviewRefresh',
            'DiffviewLog',
        },
    },
    {
        'esmuellert/codediff.nvim',
        cmd = 'CodeDiff',
    },
    {
        'NeogitOrg/neogit',
        event = 'BufRead',
        cmds = {
            'Neogit',
            'NeogitCommit',
            'NeogitLogCurrent',
            'NeogitResetState',
        },
        keys = { { '<leader>Go', mode = 'n' } },
        dependencies = {
            'nvim-lua/plenary.nvim', -- required
            'sindrets/diffview.nvim', -- optional - Diff integration
            'ibhagwan/fzf-lua', -- optional
        },
        config = function()
            require('custom.neogit')
        end,
    },
    {
        'NicholasZolton/neojj',
        lazy = true,
        dependencies = {
            'nvim-lua/plenary.nvim', -- required
            'esmuellert/codediff.nvim', -- optional
            'folke/snacks.nvim', -- optional
        },
        cmd = 'Neojj',
        keys = {
            { '<leader>Gj', '<cmd>Neojj<cr>', desc = 'Show Neojj UI' },
        },
    },
    {
        'tpope/vim-fugitive',
    },
    {
        'akinsho/git-conflict.nvim',
        version = '*',
        config = true,
        event = 'BufRead',
    },
    {
        'nicolasgb/jj.nvim',
        version = '*', -- Use latest stable release
        -- Or from the main branch (uncomment the branch line and comment the version line)
        -- branch = "main",
        config = function()
            require('jj').setup({})
        end,
    },
}

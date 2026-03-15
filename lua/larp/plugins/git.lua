return {
    {
        'lewis6991/gitsigns.nvim',
        event = 'BufRead',
        config = function()
            require('custom.gitsigns')
        end,
    },
    {
        'esmuellert/codediff.nvim',
        cmd = { 'CodeDiff', 'VscodeDiff' },
    },
    {
        'julienvincent/hunk.nvim',
        cmd = { 'DiffEditor' },
        config = true,
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
            { '<leader>gj', '<cmd>Neojj<cr>', desc = 'Show Neojj UI' },
        },
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
        event = 'VeryLazy',
        opts = {},
    },
}

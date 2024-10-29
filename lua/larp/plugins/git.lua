return {
    {
        'kdheepak/lazygit.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        keys = {
            { '<leader>Gl', mode = { 'n', 'x' }, '<cmd>LazyGit<cr>', noremap = true, silent = true, desc = 'LazyGit' },
        },
    },
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
    },
    {
        'NeogitOrg/neogit',
        event = 'BufRead',
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
        'tpope/vim-fugitive',
    },
}

return {
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
}

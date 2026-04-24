return {
    'ThePrimeagen/refactoring.nvim',
    cmd = 'Refactor',
    keys = {
        {
            '<Leader>crr',
            function()
                require('refactoring').select_refactor()
            end,
            desc = '[Refactoring] Select Refactor',
        },
    },
    dependencies = {
        'lewis6991/async.nvim',
    },
}

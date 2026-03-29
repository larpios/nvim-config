return {
    'MagicDuck/grug-far.nvim',
    cmd = { 'GrugFar', 'GrugFarWithin' },
    keys = {
        {
            '<leader>rg',
            function()
                require('grug-far').open()
            end,
            mode = 'n',
            desc = '[GrugFar] Open GrugFar',
        },
        {
            '<leader>rg',
            function()
                require('grug-far').with_visual_selection()
            end,
            mode = 'x',
            desc = '[GrugFar] Open GrugFar',
        },
    },
    opts = {},
}

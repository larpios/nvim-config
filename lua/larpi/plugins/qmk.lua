local glove80 = {
    name = 'LAYOUT_glove80', -- identify your layout name
    comment_preview = {
        keymap_overrides = {
            MG = 'Magic', -- replace any long key codes
        },
    },
    variant = 'zmk',
    layout = { -- create a visual representation of your final layout
        'x x x x x _ _ _ _ _ _ _ _ x x x x x',
        'x x x x x x _ _ _ _ _ _ x x x x x x',
        'x x x x x x _ _ _ _ _ _ x x x x x x',
        'x x x x x x _ _ _ _ _ _ x x x x x x',
        'x x x x x x x x x x x x x x x x x x',
        'x x x x x _ x x x x x x _ x x x x x',
    },
}

local voyager = {
    name = 'LAYOUT_voyager', -- identify your layout name
    variant = 'qmk',
    comment_preview = {
        keymap_overrides = {
            TRANSPARENT = 'Trans',
        },
    },
    layout = { -- create a visual representation of your final layout
        'x x x x x x _ _ x x x x x x',
        'x x x x x x _ _ x x x x x x',
        'x x x x x x _ _ x x x x x x',
        'x x x x x x _ _ x x x x x x',
        '_ _ _ _ _ x x x x _ _ _ _ _',
    },
}

return {
    'codethread/qmk.nvim',
    cmd = 'QMKFormat',
    keys = {
        { '<leader>qf', '<cmd>QMKFormat<cr>', desc = 'Format QMK' },
    },
    opts = voyager,
}

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
            KC_TRANSPARENT = 'trans',
            KC_PRINT_SCREEN = 'print',
            KC_LEFT_ALT = 'LALT',
            KC_LEFT_CTRL = 'LCTRL',
            KC_LEFT_SHIFT = 'LSHIFT',
            KC_RIGHT_ALT = 'RALT',
            KC_RIGHT_CTRL = 'RCTRL',
            KC_RIGHT_SHIFT = 'RSHIFT',
            KC_LEFT_GUI = 'LGUI',
            KC_RIGHT_GUI = 'RGUI',
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
    'larpios/qmk.nvim',
    branch = 'test',
    cmd = 'QMKFormat',
    keys = {
        { '<leader>qf', '<cmd>QMKFormat<cr>', desc = 'Format QMK' },
    },
    opts = voyager,
}

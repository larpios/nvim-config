local transparent = require('transparent')
local opts = {
    groups = {
        'Normal',
        'NormalNC',
        'Comment',
        'Constant',
        'Special',
        'Identifier',
        'Statement',
        'PreProc',
        'Type',
        'Underlined',
        'Todo',
        'String',
        'Function',
        'Conditional',
        'Repeat',
        'Operator',
        'Structure',
        'LineNr',
        'NonText',
        'SignColumn',
        -- 'CursorLine',
        'CursorLineNr',
        'StatusLine',
        'StatusLineNC',
        'EndOfBuffer',
    },
    extra_groups = {
        'SnacksPicker',
        'FloatTitle',
        'FloatBorder',
    },
}

transparent.setup(opts)

transparent.clear_prefix('WhichKey')

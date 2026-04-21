return {
    -- For transparent background
    'xiyaowong/transparent.nvim',
    -- Modify this to enable/disable transparent background
    enabled = true,
    lazy = false,
    priority = 500,
    opts = {
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
            'SnacksPickerInput',
            'FloatTitle',
            'FloatBorder',
            'FzfLuaNormal',
            'MasonNormal',
            'MiniFilesNormal',
        },
    },
    config = function(_, opts)
        local transparent = require('transparent')
        transparent.setup(opts)

        transparent.clear_prefix('WhichKey')
    end,
}

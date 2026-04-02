return {
    'larpios/jj-conflict.nvim',
    version = '*',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = {
        'JjConflictList',
        'JjConflictChooseBoth',
        'JjConflictChooseNone',
        'JjConflictChooseOurs',
        'JjConflictChooseTheirs',
        'JjConflictNextConflict',
        'JjConflictPrevConflict',
    },
    opts = {
        default_mappings = true,
        mappings_prefix = '[JjConflict]',
        mappings = {
            ours = 'gho',
            theirs = 'ght',
            both = 'ghb',
            none = 'gh0',
            next = 'ghn',
            prev = 'ghp',
        },
    },
}

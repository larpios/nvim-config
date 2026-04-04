return {
    'larpios/jj-conflict.nvim',
    branch = 'dev',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'folke/snacks.nvim',
    },
    cmd = {
        'JjConflictList',
        'JjConflictChooseBoth',
        'JjConflictChooseNone',
        'JjConflictChooseOurs',
        'JjConflictChooseTheirs',
        'JjConflictNextConflict',
        'JjConflictPrevConflict',
        'JjConflictSquash',
        'JjConflictResolve',
        'JjConflictLog',
        'JjConflictStatus',
        'JjConflictDiff',
    },
    opts = {
        default_mappings = true,
        desc_prefix = '[JjConflict]',
    },
}

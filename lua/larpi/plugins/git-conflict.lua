return {
    -- Visualize git conflicts
    'akinsho/git-conflict.nvim',
    version = '*',
    config = true,
    event = { 'BufReadPre', 'BufNewFile' },
}

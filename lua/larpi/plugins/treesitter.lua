return {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile', 'SessionLoadPost' },
    branch = 'main',
    build = ':TSUpdate',
}


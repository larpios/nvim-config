return {
    'romus204/tree-sitter-manager.nvim',
    dependencies = {}, -- tree-sitter CLI must be installed system-wide
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = 'TSManager',
    config = function()
        require('tree-sitter-manager').setup({
            ensure_installed = { 'vim', 'lua', 'rust', 'cpp', 'c' },
            auto_install = true,
        })
    end,
}

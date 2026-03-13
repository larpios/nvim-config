return {
    -- # Provides various useful modules
    'echasnovski/mini.nvim',
    version = '*',
    lazy = false,
    config = function()
        require('custom.mini')
    end,
}

return {
    'rcarriga/nvim-notify',
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
    },
    config = function()
        require('notify').setup({
            render = 'compact',
            stages = 'slide',
            timeout = 5000,
            background_colour = '#000000',
            icons = {
                ERROR = '',
                WARN = '',
                INFO = '',
                DEBUG = '',
                TRACE = '✎',
            },
        })
        vim.keymap.set('n', '<leader>fn', '<cmd>Telescope notify<cr>', {desc = "Find Notify History"})
    end
}

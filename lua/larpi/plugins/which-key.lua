return {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    keys = {
        {
            '<leader>?',
            function()
                require('which-key').show({ global = false })
            end,
            mode = { 'n', 'x' },
            desc = '[WhichKey] Show Local Keybindings',
        },
    },
    opts = {
        triggers = {
            { '<auto>', mode = 'nixsotc' },
            { 'a', mode = { 'n', 'v' } },
        },
        preset = 'modern',
    },
}

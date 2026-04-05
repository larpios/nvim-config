return {
    'nickjvandyke/opencode.nvim',
    version = '*', -- Latest stable release
    dependencies = {
        {
            -- `snacks.nvim` integration is recommended, but optional
            ---@module "snacks" <- Loads `snacks.nvim` types for configuration intellisense
            'folke/snacks.nvim',
            optional = true,
            opts = {
                input = {}, -- Enhances `ask()`
                picker = { -- Enhances `select()`
                    actions = {
                        opencode_send = function(...)
                            return require('opencode').snacks_picker_send(...)
                        end,
                    },
                    win = {
                        input = {
                            keys = {
                                ['<a-a>'] = { 'opencode_send', mode = { 'n', 'i' } },
                            },
                        },
                    },
                },
            },
        },
    },
    keys = {
        -- Recommended/example keymaps
        {
            '<leader>aoa',
            function()
                require('opencode').ask('@this: ', { submit = true })
            end,
            mode = { 'n', 'x' },
            desc = '[Opencode] Ask opencode…',
        },
        {
            '<leader>aox',
            function()
                require('opencode').select()
            end,
            mode = { 'n', 'x' },
            desc = '[Opencode] Execute opencode action…',
        },
        {
            '<leader>aot',
            function()
                require('opencode').toggle()
            end,
            mode = { 'n', 'x' },
            desc = '[Opencode] Toggle opencode',
        },
        {
            'go',
            function()
                return require('opencode').operator('@this ')
            end,
            mode = { 'n', 'x' },
            expr = true,
            desc = '[Opencode] Add range to opencode',
        },
        {
            'goo',
            function()
                return require('opencode').operator('@this ') .. '_'
            end,
            mode = 'n',
            expr = true,
            desc = '[Opencode] Add line to opencode',
        },
        {
            '<S-C-u>',
            function()
                require('opencode').command('session.half.page.up')
            end,
            mode = 'n',
            desc = '[Opencdode] Scroll opencode up',
        },
        {
            '<S-C-d>',
            function()
                require('opencode').command('session.half.page.down')
            end,
            mode = 'n',
            desc = '[Opencode] Scroll opencode down',
        },
    },
    init = function()
        vim.g.opencode_opts = {}
        vim.o.autoread = true -- Required for `opts.events.reload`
    end,
}

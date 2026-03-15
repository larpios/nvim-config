return {
    {
        'monkoose/neocodeium',
        event = 'InsertEnter',
        opts = {},
        keys = {
            {
                '<A-a>',
                function()
                    require('neocodeium').accept()
                end,
                mode = 'i',
            },
        },
    },
    {
        'David-Kunz/gen.nvim',
        event = 'VeryLazy',
        opts = {
            model = 'deepseek-coder-v2:lite',
            quit_map = 'q',
            show_prompt = false,
            show_model = false,
        },
    },
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        opts = {},
    },
    {
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
        config = function()
            ---@type opencode.Opts
            vim.g.opencode_opts = {
                -- Your configuration, if any; goto definition on the type or field for details
            }

            vim.o.autoread = true -- Required for `opts.events.reload`

            -- Recommended/example keymaps
            vim.keymap.set({ 'n', 'x' }, '<leader>aoa', function()
                require('opencode').ask('@this: ', { submit = true })
            end, { desc = '[Opencode] Ask opencode…' })
            vim.keymap.set({ 'n', 'x' }, '<leader>aox', function()
                require('opencode').select()
            end, { desc = '[Opencode] Execute opencode action…' })
            vim.keymap.set({ 'n', 't' }, '<leader>aot', function()
                require('opencode').toggle()
            end, { desc = '[Opencode] Toggle opencode' })

            vim.keymap.set({ 'n', 'x' }, 'go', function()
                return require('opencode').operator('@this ')
            end, { desc = '[Opencode] Add range to opencode', expr = true })
            vim.keymap.set('n', 'goo', function()
                return require('opencode').operator('@this ') .. '_'
            end, { desc = '[Opencode] Add line to opencode', expr = true })

            vim.keymap.set('n', '<S-C-u>', function()
                require('opencode').command('session.half.page.up')
            end, { desc = '[Opencdode] Scroll opencode up' })
            vim.keymap.set('n', '<S-C-d>', function()
                require('opencode').command('session.half.page.down')
            end, { desc = '[Opencode] Scroll opencode down' })
        end,
    },
}

return {
    {
        'monkoose/neocodeium',
        event = 'VeryLazy',
        config = function()
            local neocodeium = require('neocodeium')
            neocodeium.setup()
            vim.keymap.set('i', '<A-a>', neocodeium.accept)
        end,
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
        'yetone/avante.nvim',
        event = 'VeryLazy',
        version = false,
        opts = {
            provider = 'ollama',
            -- FIXED: Changed 'vendors' to 'providers'
            providers = {
                ollama = {
                    __inherited_from = 'openai',
                    api_key_name = '',
                    endpoint = 'http://127.0.0.1:11434/v1',
                    model = 'deepseek-coder-v2:lite',
                },
            },
            auto_set_keymaps = true,
            -- REMOVED: auto_suggestions_provider = "neocodeium" (not supported)
            mappings = {
                edit = '<C-e>',
                jump_next = ']a',
                jump_prev = '[a',
            },
        },
        build = 'make',
        dependencies = {
            'stevearc/dressing.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
    },
    {
        'zbirenbaum/copilot.lua',
        cmd = 'Copilot',
        event = 'InsertEnter',
        config = function()
            require('copilot').setup()
        end,
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
            vim.keymap.set({ 'n', 'x' }, '<C-a>', function()
                require('opencode').ask('@this: ', { submit = true })
            end, { desc = 'Ask opencode…' })
            vim.keymap.set({ 'n', 'x' }, '<C-x>', function()
                require('opencode').select()
            end, { desc = 'Execute opencode action…' })
            vim.keymap.set({ 'n', 't' }, '<C-.>', function()
                require('opencode').toggle()
            end, { desc = 'Toggle opencode' })

            vim.keymap.set({ 'n', 'x' }, 'go', function()
                return require('opencode').operator('@this ')
            end, { desc = 'Add range to opencode', expr = true })
            vim.keymap.set('n', 'goo', function()
                return require('opencode').operator('@this ') .. '_'
            end, { desc = 'Add line to opencode', expr = true })

            vim.keymap.set('n', '<S-C-u>', function()
                require('opencode').command('session.half.page.up')
            end, { desc = 'Scroll opencode up' })
            vim.keymap.set('n', '<S-C-d>', function()
                require('opencode').command('session.half.page.down')
            end, { desc = 'Scroll opencode down' })

            -- You may want these if you use the opinionated `<C-a>` and `<C-x>` keymaps above — otherwise consider `<leader>o…` (and remove terminal mode from the `toggle` keymap)
            vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment under cursor', noremap = true })
            vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement under cursor', noremap = true })
        end,
    },
}

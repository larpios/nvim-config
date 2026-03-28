return {
    {
        'monkoose/neocodeium',
        event = 'InsertEnter',
        opts = {},
        cmd = 'NeoCodeium',
        keys = {
            {
                '<A-f>',
                function()
                    require('neocodeium').accept()
                end,
                mode = 'i',
            },
        },
    },
    {
        'David-Kunz/gen.nvim',
        cmd = 'Gen',
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
        'olimorris/codecompanion.nvim',
        version = '^19.0.0',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        cmd = 'CodeCompanion',
        keys = {
            {
                '<leader>acc',
                function()
                    require('codecompanion').chat()
                end,
                desc = '[CodeCompanion] Chat',
            },
            {
                '<leader>act',
                function()
                    require('codecompanion').toggle()
                end,
                desc = '[CodeCompanion] Toggle',
            },
        },
        opts = {
            interactions = {
                chat = {
                    adapter = 'ollama',
                    model = 'qwen2.5-coder:32b',
                },
            },
        },
        config = function(_, opts)
            local cc = require('codecompanion')
            cc.setup(opts)

            vim.api.nvim_create_user_command('CodeCompanion', function(args)
                local subcmd = args.fargs[1]

                if subcmd == 'chat' then
                    cc.chat()
                elseif subcmd == 'toggle' then
                    cc.toggle()
                end
            end, {
                nargs = 1,
                complete = function(arg_lead, cmd_line, cursor_pos)
                    return { 'chat', 'toggle' }
                end,
            })
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
                mode = { 'n', 't' },
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
    },
}

return {
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
}

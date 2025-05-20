return {
    -- {
    --     'numToStr/Comment.nvim',
    --     opts = {},
    --     lazy = false,
    -- },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
        config = function()
            require('custom.indent-blankline')
        end,
    },
    {
        'chrisgrieser/nvim-rip-substitute',
        cmd = 'RipSubstitute',
        keys = {
            { '<leader>rs', mode = { 'n', 'x' } },
        },
        config = function()
            larp.fn.map({ 'n', 'x' }, '<leader>rs', function()
                require('rip-substitute').sub()
            end)
        end,
    },
    {
        'cshuaimin/ssr.nvim',
        module = 'ssr',
        -- Calling setup is optional.

        config = function()
            require('custom.ssr')
        end,
    },
    {
        'smjonas/live-command.nvim',
        -- live-command supports semantic versioning via Git tags
        -- tag = "2.*",
        config = function()
            require('live-command').setup({
                commands = {
                    Norm = { cmd = 'norm' },
                },
            })
        end,
    },
    -- lazy.nvim
    {
        'chrisgrieser/nvim-rip-substitute',
        cmd = 'RipSubstitute',
        keys = {
            {
                '<leader>fs',
                function()
                    require('rip-substitute').sub()
                end,
                mode = { 'n', 'x' },
                desc = ' rip substitute',
            },
        },
    },
    -- {
    --     'jake-stewart/multicursor.nvim',
    --     branch = '1.0',
    --     config = function()
    --         require('custom.multicursor')
    --     end,
    -- },
    -- {
    --     'gennaro-tedesco/nvim-peekup',
    -- },
    -- lazy.nvim
    {
        'chrisgrieser/nvim-scissors',
        dependencies = { 'nvim-telescope/telescope.nvim', 'garymjr/nvim-snippets' },
        opts = {
            snippetDir = vim.fn.stdpath('config') .. '/snippets',
        },
        keys = {
            {
                '<leader>se',
                function()
                    require('scissors').editSnippet()
                end,
                mode = { 'n' },
                desc = ' edit snippet',
            },
            {
                '<leader>sa',
                function()
                    require('scissors').addNewSnippet()
                end,
                mode = { 'n', 'x' },
                desc = ' add new snippet',
            },
        },
    },

    {
        -- Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
        'chrisgrieser/nvim-spider',
        event = 'BufRead',
        config = function()
            require('custom.nvim-spider')
        end,
    },
    -- {
    --     'willothy/flatten.nvim',
    --     config = true,
    --     -- or pass configuration with
    --     -- opts = {  }
    --     -- Ensure that it runs first to minimize delay when opening file from terminal
    --     lazy = false,
    --     priority = 1001,
    -- },
    {
        'HiPhish/rainbow-delimiters.nvim',
    },
    {
        'AckslD/nvim-neoclip.lua',
        dependencies = {
            -- {'nvim-telescope/telescope.nvim'},
            { 'ibhagwan/fzf-lua' },
        },
        config = function()
            require('custom.nvim-neoclip')
        end,
    },
    {
        'LintaoAmons/scratch.nvim',
        event = 'VeryLazy',
    },
    {
        'ibhagwan/smartyank.nvim',
        opts = {
            osc52 = {
                enabled = true,
                ssh_only = true,
                silent = false,
            },
            clipboard = {
                enabled = false,
            },
        },
    }
}

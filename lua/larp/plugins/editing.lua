return {
    {
        'numToStr/Comment.nvim',
        opts = {},
        lazy = false,
    },
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        keys = {
            {
                's',
                mode = { 'n', 'x', 'o' },
            },
            {
                'SS',
                mode = { 'n', 'x', 'o' },
            },
            {
                'Sh',
                mode = { 'n', 'x', 'o' },
            },
            {
                'r',
                mode = 'o',
            },
            {
                'R',
                mode = { 'o', 'x' },
            },
            {
                '<c-s>',
                mode = { 'c' },
            },
        },
        config = function()
            require('custom.flash')
        end,
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
        config = function()
            require('custom.indent-blankline')
        end,
    },
    {
        'kylechui/nvim-surround',
        -- To give mini.surround a try.
        enabled = false,
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
    {
        'mbbill/undotree',
        keys = {
            {
                '<leader>tu',
                function()
                    vim.cmd.UndotreeToggle()
                end,
                mode = { 'n' },
                desc = 'Toggle UndoTree',
            },
        },
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
    {
        'jake-stewart/multicursor.nvim',
        branch = '1.0',
        config = function()
            require('custom.multicursor')
        end,
    },
    {
        'gennaro-tedesco/nvim-peekup',
    },
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
    {
        'willothy/flatten.nvim',
        config = true,
        -- or pass configuration with
        -- opts = {  }
        -- Ensure that it runs first to minimize delay when opening file from terminal
        lazy = false,
        priority = 1001,
    },
    {

        'HiPhish/rainbow-delimiters.nvim',
    },
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        dependencies = {
            { 'github/copilot.vim' }, -- or zbirenbaum/copilot.lua
            { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
        },
        build = 'make tiktoken', -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
    {
        'olimorris/codecompanion.nvim',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        config = true,
    },
}

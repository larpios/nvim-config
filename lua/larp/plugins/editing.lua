return {
    {
        'chrisgrieser/nvim-rip-substitute',
        cmd = 'RipSubstitute',
        keys = {
            {
                '<leader>rr',
                function()
                    require('rip-substitute').sub()
                end,
                mode = { 'n', 'x' },
            },
        },
        opts = {},
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
        'chrisgrieser/nvim-scissors',
        dependencies = 'folke/snacks.nvim',
        opts = {
            snippetDir = vim.fn.stdpath('config') .. '/snippets',
        },
        cmd = {
            'ScissorsAddNewSnippet',
            'ScissorsEditSnippet',
        },
        keys = {
            {
                '<leader>Se',
                function()
                    require('scissors').editSnippet()
                end,
                mode = { 'n' },
                desc = '[Scissors]  edit snippet',
            },
            {
                '<leader>Sa',
                function()
                    require('scissors').addNewSnippet()
                end,
                mode = { 'n', 'x' },
                desc = '[Scissors]  add new snippet',
            },
        },
    },

    {
        -- Use the w, e, b motions like a spider. Move by subwords and skip insignificant punctuation.
        'chrisgrieser/nvim-spider',
        event = 'BufRead',
        keys = {
            {
                'w',
                function()
                    require('spider').motion('w')
                end,
                mode = { 'n', 'o', 'x' },
                desc = 'Spider-w',
            },
            {
                'e',
                function()
                    require('spider').motion('e')
                end,
                mode = { 'n', 'o', 'x' },
                desc = 'Spider-e',
            },
            {
                'b',
                function()
                    require('spider').motion('b')
                end,
                mode = { 'n', 'o', 'x' },
                desc = 'Spider-b',
            },
            {
                '<C-f>',
                '<Esc>l<cmd>lua require("spider").motion("w")<CR>i',
                mode = 'i',
            },
            {
                '<C-b>',
                '<Esc><cmd>lua require("spider").motion("b")<CR>i',
                mode = 'i',
            },
        },
        config = true,
    },
    {
        'HiPhish/rainbow-delimiters.nvim',
        dependencies = 'nvim-treesitter/nvim-treesitter',
        config = function()
            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = 'rainbow-delimiters.strategy.global',
                },
                query = {
                    [''] = 'rainbow-delimiters',
                },
                condition = function(bufnr)
                    -- Check if treesitter parser is available for the buffer
                    local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
                    local ok = pcall(vim.treesitter.get_parser, bufnr, lang)
                    return ok
                end,
                blacklist = {
                    'oil',
                    'noice',
                    'notify',
                    'lazy',
                    'mason',
                    'Trouble',
                    'alpha',
                    'dashboard',
                    'neo-tree',
                    'NvimTree',
                    'fidget',
                    'snacks_notif',
                    'snacks_notif_history',
                    'snacks_terminal',
                    'snacks_win',
                    'snacks_input',
                    'blink-cmp-menu',
                    'blink-cmp-signature-help',
                    'blink-cmp-documentation',
                },
            }
        end,
    },
    {
        'ibhagwan/smartyank.nvim',
        event = 'VeryLazy',
        opts = {
            highlight = {
                enabled = true,
                higroup = 'IncSearch',
                timeout = 200,
            },
            osc52 = {
                enabled = true,
                ssh_only = true,
                silent = false,
            },
            clipboard = {
                enabled = false,
            },
        },
    },
    {
        'jiaoshijie/undotree',
        ---@module 'undotree.collector'
        ---@type UndoTreeCollector.Opts
        opts = {
            -- your options
        },
        keys = { -- load the plugin only when using it's keybinding:
            { '<leader>tu', "<cmd>lua require('undotree').toggle()<cr>" },
        },
    },
    {
        -- Enhance the usage of macros in Neovim
        "chrisgrieser/nvim-recorder",
        opts = {},                      -- required even with default settings, since it calls `setup()`
    },
}

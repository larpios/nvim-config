return {
    {
        'numToStr/Comment.nvim',
        enabled = false,
        opts = {
            -- add any options here
        },
        lazy = false,
        config = function()
            require('Comment').setup()
        end,
    },
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        opts = {},
        keys = {
            {
                's',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            {
                '<leader>s',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').treesitter()
                end,
                desc = 'Flash Treesitter',
            },
            {
                'r',
                mode = 'o',
                function()
                    require('flash').remote()
                end,
                desc = 'Remote Flash',
            },
            {
                'R',
                mode = { 'o', 'x' },
                function()
                    require('flash').treesitter_search()
                end,
                desc = 'Treesitter Search',
            },
            {
                '<c-s>',
                mode = { 'c' },
                function()
                    require('flash').toggle()
                end,
                desc = 'Toggle Flash Search',
            },
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
        config = function()
            local highlight = {
                'RainbowRed',
                'RainbowYellow',
                'RainbowBlue',
                'RainbowOrange',
                'RainbowGreen',
                'RainbowViolet',
                'RainbowCyan',
            }
            local hooks = require('ibl.hooks')
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
                vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
                vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
                vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
                vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
                vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
                vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require('ibl').setup({
                scope = { highlight = highlight },
                exclude = {
                    filetypes = {
                        'dashboard', -- Exclude dashboard buffer by dashboard.nvim
                    },
                },
            })

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
    {
        'kylechui/nvim-surround',
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
            require('ssr').setup({
                border = 'rounded',
                min_width = 50,
                min_height = 5,
                max_width = 120,
                max_height = 25,
                adjust_window = true,
                keymaps = {
                    close = 'q',
                    next_match = 'n',
                    prev_match = 'N',
                    replace_confirm = '<cr>',
                    replace_all = '<leader><cr>',
                },
            })
            larp.fn.map({ 'n', 'x' }, '<leader><leader>sr', function()
                require('ssr').open()
            end)
        end,
    },
    {
        'ptdewey/yankbank-nvim',
        dependencies = 'kkharji/sqlite.lua',
        config = function()
            require('yankbank').setup({
                persist_type = 'sqlite',
            })
            -- map to '<leader>y'
            larp.fn.map('n', '<leader><leader>y', '<cmd>YankBank<CR>', { noremap = true })
        end,
    },
    {
        'smjonas/live-command.nvim',
        event = 'VeryLazy',
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
}

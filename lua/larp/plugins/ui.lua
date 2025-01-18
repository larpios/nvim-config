return {
    {
        'nvim-lualine/lualine.nvim',
        event = 'BufWinEnter',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'stevearc/overseer.nvim',
        },
        config = function()
            require('custom.lualine')
        end,
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            'MunifTanjim/nui.nvim',
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            'rcarriga/nvim-notify',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('custom.noice')
        end,
    },
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        -- Loading screen on the bottom right
        'j-hui/fidget.nvim',
        event = 'VeryLazy',
        opts = {
            -- options
        },
    },
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        },
    },
    {
        -- Peek buffer while typing :<linenumber>
        'nacro90/numb.nvim',
        config = true,
    },
    {
        'rcarriga/nvim-notify',
        lazy = true,
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('custom.nvim-notify')
        end,
    },
    { 'petertriho/nvim-scrollbar' },
    {
        'stevearc/oil.nvim',
        tag = 'stable',
        dependencies = {
            'echasnovski/mini.icons',
        },
        config = function()
            require('custom.oil')
        end,
    },
    {
        'folke/trouble.nvim',
        branch = 'main', -- IMPORTANT!
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>cs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>cl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>xL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = 'Location List (Trouble)',
            },
            {
                '<leader>xQ',
                '<cmd>Trouble qflist toggle<cr>',
                desc = 'Quickfix List (Trouble)',
            },
        },
        opts = {}, -- for default options, refer to the configuration section for custom setup.
    },
    {
        'RRethy/vim-illuminate',
        event = 'BufRead',
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        'folke/zen-mode.nvim',
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            { '<leader>tz', '<cmd>ZenMode<cr>', desc = 'Toggle Zen Mode' },
        },
    },
    -- {
    --     -- Scrollbar
    --     'lewis6991/satellite.nvim',
    --     event = 'BufRead',
    -- },
    {
        'simonmclean/triptych.nvim',
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim', -- required
            'nvim-tree/nvim-web-devicons', -- optional
        },
        keys = {
            { '<leader><leader>t', '<cmd>Triptych<cr>', mode = 'n', desc = 'Toggle Triptych' },
        },
        opts = {},
    },
    {
        -- Colorful window separator
        'nvim-zh/colorful-winsep.nvim',
        config = true,
        event = { 'WinLeave' },
    },
    {
        -- Changes the color of the line number depending on the current mode.
        'mawkler/modicator.nvim',
        event = 'VeryLazy',
        init = function()
            -- These are required for Modicator to work
            vim.o.cursorline = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        opts = {},
    },
    {
        'nvzone/showkeys',
        -- cmd = 'ShowkeysToggle',
        config = function()
            require('custom.showkeys')
        end,
    },
}

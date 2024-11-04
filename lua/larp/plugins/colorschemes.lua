return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        config = function()
            require('catppuccin').setup({
                transparent_background = true,
                styles = {
                    sidebars = 'transparent',
                    floats = 'transparent',
                },
                default_integrations = true,
                integrations = {
                    cmp = true,
                    gitsigns = true,
                    nvimtree = true,
                    treesitter = true,
                    notify = true,
                    mini = {
                        enabled = true,
                        indentscope_color = '',
                    },
                    dashboard = true,
                },
            })
        end,
    },
    {
        'folke/tokyonight.nvim',
        enabled = false,
        lazy = false,
        priority = 1000,
        opts = {},
    },

    {
        'mawkler/onedark.nvim',
        enabled = false,
        priority = 1000,
        opts = {
            style = 'darker',
        },
        config = function()
            require('onedark').setup({})
        end,
    },

    -- Or with configuration
    {
        'projekt0n/github-nvim-theme',
        enabled = false,
        name = 'github-theme',
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function()
            require('github-theme').setup({
                -- ...
            })
        end,
    },
}

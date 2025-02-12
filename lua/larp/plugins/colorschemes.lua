return {
    {
        'catppuccin/nvim',
        name = 'catppuccin',
        priority = 1000,
        config = function()
            require('custom.catppuccin')
        end,
    },
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
        opts = {},
        config = function()
            vim.cmd.colorscheme('tokyonight-moon')
        end,
    },
    --
    -- {
    --     'mawkler/onedark.nvim',
    --     priority = 1000,
    --     opts = {
    --         style = 'darker',
    --     },
    --     config = function()
    --         require('onedark').setup({})
    --     end,
    -- },
    -- {
    --     'projekt0n/github-nvim-theme',
    --     enabled = false,
    --     name = 'github-theme',
    --     lazy = false, -- make sure we load this during startup if it is your main colorscheme
    --     priority = 1000, -- make sure to load this before all the other start plugins
    --     config = function()
    --         require('github-theme').setup({
    --             -- ...
    --         })
    --     end,
    -- },
}

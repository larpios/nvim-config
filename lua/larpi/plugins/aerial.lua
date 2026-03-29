return {
    'stevearc/aerial.nvim',
    opts = {
        -- optionally use on_attach to set keymaps when aerial has attached to a buffer
        on_attach = function(bufnr)
            -- Jump forwards/backwards with '{' and '}'
            vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
            vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end,
        autojump = true,
        filter_kind = false,
    },
    -- Optional dependencies
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-tree/nvim-web-devicons',
    },
    cmd = { 'AerialToggle' },
    keys = {
        {
            '<leader>to',
            function()
                require('aerial').toggle()
            end,
            desc = '[Aerial] Toggle Overview',
        },
    },
}

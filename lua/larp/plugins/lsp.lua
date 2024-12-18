return {
    {
        'ray-x/lsp_signature.nvim',
        event = 'VeryLazy',
        opts = {
            bind = true,
            handle_opts = {
                border = 'rounded',
            },
        },
    },
    {

        'L3MON4D3/LuaSnip',
        event = 'InsertEnter',
        -- follow latest release.
        version = 'v2.*', -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = 'make install_jsregexp',
        dependencies = {
            'saadparwaiz1/cmp_luasnip',
        },
    },
    {
        'stevearc/conform.nvim',
        event = 'LspAttach',
        opts = {},
        config = function()
            require('custom.conform')
        end,
    },

    {
        'mrcjkb/rustaceanvim',
        version = '^5', -- Recommended
        lazy = false, -- This plugin is already lazy
        config = function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.keymap.set('n', '<leader>a', function()
                vim.cmd.RustLsp('codeAction') -- supports rust-analyzer's grouping
                -- or vim.lsp.buf.codeAction() if you don't want grouping.
            end, { silent = true, buffer = bufnr })
        end,
    },
    {
        'rust-lang/rust.vim',
        ft = 'rust',
        init = function()
            vim.g.rustfmt_autosave = 1
        end,
    },
    {
        'simrat39/rust-tools.nvim',
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
            'mfussenegger/nvim-dap',
        },
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        event = 'BufEnter',
        branch = 'v4.x',
        dependencies = {
            { 'neovim/nvim-lspconfig' },
            { 'hrsh7th/cmp-nvim-lsp' },
            {
                -- nvim-cmp is apparenty not being that well maintained.
                -- Someone has forked it and merged some pull requests and stuff.
                -- Until it gets well maintained again, I'll use this fork.
                -- 'hrsh7th/nvim-cmp' ,
                'iguanacucumber/magazine.nvim',
                name = 'nvim-cmp', -- Otherwise highlighting gets messed up
            },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-nvim-lua' },
            -- { 'hrsh7th/cmp-cmdline' },
            { 'rafamadriz/friendly-snippets' },
            { 'L3MON4D3/LuaSnip' },
            { 'onsails/lspkind.nvim' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },
            { 'mrcjkb/rustaceanvim' },
        },
        -- TODO: Have sources show up in the completion menu. The default one does, but lspkind overwrites it.
        config = function()
            require('custom.lsp-zero')
        end,
    },
    {
        'windwp/nvim-autopairs',
        event = 'InsertEnter',
        config = true,
    },
    {
        -- Better folding
        'kevinhwang91/nvim-ufo',
        dependencies = { 'kevinhwang91/promise-async' },
        init = function()
            vim.o.foldcolumn = '0'
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
        end,
        config = function()
            require('custom.nvim-ufo')
        end,
    },
    {
        -- Stops inactive LSP servers to free RAM
        'zeioth/garbage-day.nvim',
        dependencies = 'neovim/nvim-lspconfig',
        event = 'VeryLazy',
        opts = {},
    },

    {
        -- IDE-like breadcrumb navigation
        'Bekaboo/dropbar.nvim',
        -- optional, but required for fuzzy finder support
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
        },
    },
    {
        'stevearc/aerial.nvim',
        -- just to test symbols.nvim
        enabled = false,
        event = 'BufEnter',
        opts = {},
        -- Optional dependencies
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },

        config = function()
            require('custom.aerial')
        end,
    },
    {
        'oskarrrrrrr/symbols.nvim',
        config = function()
            require('custom.symbols')
        end,
    },
    {
        'saghen/blink.cmp',
        -- enabled = false,
        -- Replacement for nvim-cmp, but it's lacking for now
        -- enabled = false,
        lazy = false, -- lazy loading handled internally
        -- optional: provides snippets for the snippet source
        dependencies = {
            'rafamadriz/friendly-snippets',
            'mikavilpas/blink-ripgrep.nvim',
        },

        -- use a release tag to download pre-built binaries
        version = 'v0.*',
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- On musl libc based systems you need to add this flag
        -- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',
        config = function()
            require('custom.blink')
        end,
    },
    {
        'VidocqH/lsp-lens.nvim',
        opts = {},
    },
    {
        'mfussenegger/nvim-jdtls',
    },
    -- {
    --     'nvim-java/nvim-java',
    --     opts = {},
    --     config = function()
    --         require('lspconfig').jdtls.setup({})
    --     end,
    -- },
}

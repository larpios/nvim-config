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
        config = function() end,
    },
    -- {
    --     'rust-lang/rust.vim',
    --     ft = 'rust',
    --     init = function()
    --         vim.g.rustfmt_autosave = 1
    --     end,
    -- },
    {
        'saecki/crates.nvim',
        ft = 'toml',
        config = function()
            require('crates').setup({
                completion = {
                    cmp = {
                        enabled = true,
                    },
                },
            })
            require('cmp').setup.buffer({
                sources = {
                    { name = 'crates' },
                },
            })
        end,
    },
    {
        'simrat39/rust-tools.nvim',
        ft = { 'rust' },
        dependencies = {
            'neovim/nvim-lspconfig',
            'nvim-lua/plenary.nvim',
            'mfussenegger/nvim-dap',
        },
    },

    {
        'VonHeikemen/lsp-zero.nvim',
        event = 'BufRead',
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
        event = 'BufRead',
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
    -- {
    --     -- Stops inactive LSP servers to free RAM
    --     'zeioth/garbage-day.nvim',
    --     dependencies = 'neovim/nvim-lspconfig',
    --     event = 'VeryLazy',
    --     opts = {},
    -- },
    {
        -- IDE-like breadcrumb navigation
        'Bekaboo/dropbar.nvim',
        -- optional, but required for fuzzy finder support
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = make,
        },
        config = function()
            local dropbar_api = require('dropbar.api')
            vim.keymap.set('n', '<Leader>;', dropbar_api.pick, { desc = 'Pick symbols in winbar' })
            vim.keymap.set('n', '[;', dropbar_api.goto_context_start, { desc = 'Go to start of current context' })
            vim.keymap.set('n', '];', dropbar_api.select_next_context, { desc = 'Select next context' })
        end,
    },
    {
        'stevearc/aerial.nvim',
        -- just to test symbols.nvim
        enabled = false,
        event = 'BufRead',
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
        -- Overview panel, something like aerial
        'oskarrrrrrr/symbols.nvim',
        cmds = {
            'Symbols',
            'SymbolsOpen',
            'SymbolsClose',
        },
        keys = {
            { '<leader>ts', mode = 'n', desc = 'Toggle Symbols' },
        },
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
            'giuxtaposition/blink-cmp-copilot',
            'moyiz/blink-emoji.nvim',
        },

        -- use a release tag to download pre-built binaries
        version = 'v0.12.*',
        -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
        -- build = 'cargo build --release',
        -- On musl libc based systems you need to add this flag
        -- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',
        config = function()
            require('custom.blink')
        end,
    },
    {
        -- Shows refernce and definition info above functions
        'VidocqH/lsp-lens.nvim',
        opts = {},
    },
    {
        'mfussenegger/nvim-jdtls',
        ft = 'java',
    },
    {
        'p00f/clangd_extensions.nvim',
        opts = {},
    },
    {
        'pest-parser/pest.vim',
        ft = "pest",
    }
}

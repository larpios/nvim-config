return {
    {
        'amitds1997/remote-nvim.nvim',
        event = 'BufRead',
        version = '*', -- Pin to GitHub releases
        dependencies = {
            'nvim-lua/plenary.nvim', -- For standard functions
            'MunifTanjim/nui.nvim', -- To build the plugin UI
            'nvim-telescope/telescope.nvim', -- For picking b/w different remote methods
        },
        config = true,
    },
    {
        'github/copilot.vim',
        event = 'BufRead',
        run = 'make',
    },
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        build = function()
            vim.fn['mkdp#util#install']()
        end,
    },
    {
        'OXY2DEV/markview.nvim',
        -- Doesn't feel complete yet, until then, I'll use render-markdown
        enabled = false,
        lazy = false, -- Recommended
        -- ft = "markdown" -- If you decide to lazy-load anyway

        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            local presets = require('markview.presets')
            require('markview').setup({
                hybrid_modes = { 'n' },
                checkboxes = presets.checkboxes.nerd,
                headings = presets.headings.slanted,
                -- horizontal_rules = presets.horizontal_rules.double,
                injections = {
                    languages = {
                        markdown = {
                            --- This disables other
                            --- injected queries!
                            overwrite = true,
                            query = [[
                    (section
                        (atx_headng) @injections.mkv.fold
                        (#set! @fold))
                ]],
                        },
                    },
                },
            })

            vim.api.nvim_create_autocmd('FileType', {
                pattern = 'markdown',
                callback = function()
                    vim.cmd('Markview attach')
                end,
            })
        end,
    },
    {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {},
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
        -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
        dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    },
    {
        'nvim-neorg/neorg',
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        ft = 'norg',
        cmd = 'Neorg',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-neorg/neorg-telescope',
        }, -- Load plenary as a dependency
        version = '*', -- Pin Neorg to the latest stable release
        keys = {
            { '<leader>no', '<cmd>Neorg<CR>', desc = 'Open Neorg', mode = 'n' },
            { '<leader>nw', desc = 'Open Neorg Workspace' },
        },
        config = function()
            require('custom.neorg')
        end,
    },
    {
        'epwalsh/obsidian.nvim',
        priority = 1000,
        version = '*', -- recommended, use latest release instead of latest commit
        dependencies = {
            'nvim-lua/plenary.nvim',
            'hrsh7th/nvim-cmp',
            'ibhagwan/fzf-lua',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('custom.obsidian')
        end,
    },
    {
        'christoomey/vim-tmux-navigator',
        cmd = {
            'TmuxNavigateLeft',
            'TmuxNavigateDown',
            'TmuxNavigateUp',
            'TmuxNavigateRight',
            'TmuxNavigatePrevious',
        },
        keys = {
            { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
            { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
            { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
            { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
            { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
        },
    },
    {
        'danymat/neogen',
        enabled = false,
        config = function()
            require('neogen').setup({ snippet_engine = 'luasnip' })
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap('n', '<Leader>Dnf', ":lua require('neogen').generate()<CR>", opts)
        end,
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*"
    },
    {
        'kristijanhusak/vim-dadbod-ui',
        enabled = false,
        dependencies = {
            { 'tpope/vim-dadbod', lazy = true },
            { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
        },
        cmd = {
            'DBUI',
            'DBUIToggle',
            'DBUIAddConnection',
            'DBUIFindBuffer',
        },
        init = function()
            -- Your DBUI configuration
            vim.g.db_ui_use_nerd_fonts = 1
        end,
    },
    {
        'codethread/qmk.nvim',
        enabled = false,
        ft = { 'keymap' },
        keys = {
            { '<leader>qf', '<cmd>QMKFormat<cr>', desc = 'Format QMK' },
        },
        config = function()
            -- local conf = {
            --     name = 'LAYOUT_glove80', -- identify your layout name
            --     comment_preview = {
            --         keymap_overrides = {
            --             MG = 'Magic', -- replace any long key codes
            --         },
            --     },
            --     variant = "zmk",
            --     layout = { -- create a visual representation of your final layout
            --         'x x x x x _ _ _ _ _ _ _ _ x x x x x ',
            --         'x x x x x x _ _ _ _ _ _ x x x x x x ',
            --         'x x x x x x _ _ _ _ _ _ x x x x x x ',
            --         'x x x x x x _ _ _ _ _ _ x x x x x x ',
            --         'x x x x x x x x x x x x x x x x x x ',
            --         'x x x x x _ x x x x x x _ x x x x x ',
            --     },
            -- }
            -- require('qmk').setup(conf)
            local qmk = require('qmk')
            qmk.setup({
                name = 'LAYOUT_glove80', -- identify your layout name
                comment_preview = {
                    keymap_overrides = {
                        MG = 'Magic', -- replace any long key codes
                    },
                },
                variant = 'zmk',
                layout = { -- create a visual representation of your final layout
                    'x x x x x _ _ _ _ _ _ _ _ x x x x x',
                    'x x x x x x _ _ _ _ _ _ x x x x x x',
                    'x x x x x x _ _ _ _ _ _ x x x x x x',
                    'x x x x x x _ _ _ _ _ _ x x x x x x',
                    'x x x x x x x x x x x x x x x x x x',
                    'x x x x x _ x x x x x x _ x x x x x',
                },
            })
        end,
    },
    {
        'dhruvasagar/vim-table-mode',
    },
    {
        'nvim-orgmode/orgmode',
        enabled = false,
        dependencies = {
            {
                'chipsenkbeil/org-roam.nvim',
                -- It prevents me from using the neorg keymaps.
                -- Re-enable it when you feel like
                -- remapping the keymaps
                tag = '0.1.0',
            },
            {
                'akinsho/org-bullets.nvim',
                opts = {},
            },
        },
        event = 'VeryLazy',
        ft = { 'org' },
        config = function()
            require('custom.orgmode')
        end,
    },
    {
        'mrjones2014/smart-splits.nvim',
        dependencies = { 'kwkarlwang/bufresize.nvim' },
        lazy = false,
        config = function()
            require('custom.smart-splits')
        end,
    },
    {
        'kwkarlwang/bufresize.nvim',
        opts = {},
    },
    {
        'renerocksai/telekasten.nvim',
        dependencies = { 'nvim-telescope/telescope.nvim' },
        enabled = false,
        config = function()
            require('telekasten').setup({
                home = vim.fn.expand('~/zettelkasten'), -- Put the name of your notes directory here
            })
        end,
    },
}

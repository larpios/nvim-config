return {
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        build = function()
            vim.fn['mkdp#util#install']()
        end,
        config = function()
            require('custom.markdown-preview')
        end,
    },
    {
        -- Markdown preview plugin
        'toppair/peek.nvim',
        event = { 'VeryLazy' },
        ft = { 'markdown' },
        cmd = { 'PeekOpen', 'PeekClose' },
        build = 'deno task --quiet build:fast',
        config = function()
            require('peek').setup()
            vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
            vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
        end,
    },
    {
        -- live-preview markdown
        'OXY2DEV/markview.nvim',
        enabled = false,
        lazy = false,
        version = 'v25.*',
        config = function()
            require('custom.markview')
        end,
    },
    {
        -- live-preview markdown
        'MeanderingProgrammer/render-markdown.nvim',
        cmd = { 'RenderMarkdown' },
        ft = { 'markdown', 'vimwiki' },
        opts = {
            completions = {
                lsp = {
                    enabled = true,
                },
                blink = {
                    enabled = true,
                }
            }
        },
        config = function(_, opts)
            require('obsidian').get_client().opts.ui.enable = false
            vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces()['ObsidianUI'], 0, -1)
            require('render-markdown').setup(opts)
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'echasnovski/mini.nvim'
        },
    },
    {
        'chomosuke/typst-preview.nvim',
        ft = { 'typst' },
        version = '1.*',
        opts = {}, -- lazy.nvim will implicitly calls `setup {}`
    },
    {
        'nvim-neorg/neorg',
        enabled = false,
        -- lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        ft = 'norg',
        cmd = 'Neorg',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-neorg/neorg-telescope',
        },             -- Load plenary as a dependency
        version = '*', -- Pin Neorg to the latest stable release
        keys = {
            { '<leader>no', '<cmd>Neorg<CR>',             desc = 'Open Neorg', mode = 'n' },
            { '<leader>nw', desc = 'Open Neorg Workspace' },
        },
        config = function()
            require('custom.neorg')
        end,
    },
    {
        'epwalsh/obsidian.nvim',
        priority = 1000,
        cmd = {
            'ObsidianNew',
            'ObsidianOpen',
            'ObsidianSearch',
        },
        keys = {
            { '<leader>Off', '<cmd>ObsidianQuickSwitch<cr>', mode = 'n',                             desc = 'Search Obsidian Vault' },
            { '<leader>Ogg', '<cmd>ObsidianSearch<cr>',      mode = 'n',                             desc = 'Grep Obsidian Vault' },
            { '<leader>Ot',  '<cmd>ObsidianTOC<cr>',         mode = 'n',                             desc = 'Search Obsidian TOC' },
            { '<leader>Oft', '<cmd>ObsidianTags<cr>',        mode = 'n',                             desc = 'Find Obsidian Tags' },
            { '<leader>Oj',  '<cmd>ObsidianDailies<cr>',     mode = 'n',                             desc = 'Obsidian Journal' },
            { '<leader>Ofw', mode = 'n',                     desc = 'Search Obsidian Workspace' },
            { '<leader>Op',  mode = 'n',                     desc = 'Obsidian Pull' },
            { '<leader>Os',  mode = 'n',                     desc = 'Commit and Push Obsidian Vault' },
        },
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
        'chomosuke/typst-preview.nvim',
        ft = { 'typst' },
        version = '1.*',
        opts = {}, -- lazy.nvim will implicitly calls `setup {}`
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
        'mrjones2014/smart-splits.nvim',
        dependencies = { 'kwkarlwang/bufresize.nvim' },
        lazy = false,
        config = function()
            require('custom.smart-splits')
        end,
    },
    {
        "hat0uma/csvview.nvim",
        ft = { 'csv' },
        ---@module "csvview"
        ---@type CsvView.Options
        opts = {
            parser = { comments = { "#", "//" } },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { "if", mode = { "o", "x" } },
                textobject_field_outer = { "af", mode = { "o", "x" } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { "<Tab>", mode = { "n", "v" } },
                jump_prev_field_end = { "<S-Tab>", mode = { "n", "v" } },
                jump_next_row = { "<Enter>", mode = { "n", "v" } },
                jump_prev_row = { "<S-Enter>", mode = { "n", "v" } },
            },
        },
        cmd = { "CsvViewEnable", "CsvViewDisable", "CsvViewToggle" },
    }
}

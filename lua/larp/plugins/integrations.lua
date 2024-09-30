return {
    {
        'amitds1997/remote-nvim.nvim',
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
        priority = 30,
        depends = { 'nvim-lua/plenary.nvim' }, -- Load plenary as a dependency
        version = '*', -- Pin Neorg to the latest stable release
        config = function()
            local my_workspaces = {
                default = '~/norgs',
                personal = '~/norgs/personal',
                work = '~/norgs/work',
            }
            require('neorg').setup({
                -- Tell Neorg what modules to load
                load = {
                    ['core.defaults'] = {}, -- Load all the default modules
                    ['core.dirman'] = {
                        config = {
                            workspaces = my_workspaces,
                            index = 'index.norg',
                        },
                    },
                    ['core.completion'] = {
                        config = {
                            engine = 'nvim-cmp',
                            name = '[Neorg]',
                        },
                    }, -- Load all the default modules
                    ['core.export'] = {
                        config = {
                            export_dir = '"<export-dir>/<language>-export"',
                        },
                    }, -- Load all the default modules
                    ['core.export.markdown'] = {}, -- Load all the default modules
                    ['core.fs'] = {}, -- Load all the default modules
                    ['core.neorgcmd'] = {}, -- Load all the default modules
                    ['core.concealer'] = {},
                    ['core.syntax'] = {},
                    ['core.summary'] = {
                        config = {
                            strategy = 'default',
                        },
                    },
                    ['core.highlights'] = {},
                    ['core.integrations.treesitter'] = {
                        config = {
                            configure_parsers = true,
                            install_parsers = true,
                        },
                    },
                    ['core.queries.native'] = {},
                    ['core.integrations.nvim-cmp'] = {},
                    ['core.storage'] = {
                        config = {
                            vim.fn.stdpath('data') .. '/neorg.mpack',
                        },
                    },
                    ['core.text-objects'] = {},
                },
            })
            vim.o.conceallevel = 3
            larp.fn.map('n', '<leader>no', '<cmd>Neorg<CR>', { noremap = true, silent = true })
            larp.fn.map('n', '<leader>nw', function()
                vim.ui.select(vim.tbl_keys(my_workspaces), { prompt = 'Workspace: ' }, function(input)
                    vim.cmd('Neorg workspace ' .. input)
                end)
            end, { noremap = true, silent = true })
            vim.api.nvim_create_autocmd('Filetype', {
                pattern = 'norg',
                callback = function()
                    larp.fn.map('n', '<up>', '<Plug>(neorg.text-objects.item-up)', { desc = 'Move item up' })
                    larp.fn.map('n', '<down>', '<Plug>(neorg.text-objects.item-down)', { desc = 'Move item down' })
                    larp.fn.map({ 'o', 'x' }, 'iH', '<Plug>(neorg.text-objects.textobject.heading.inner)', { desc = 'Select heading' })
                    larp.fn.map({ 'o', 'x' }, 'aH', '<Plug>(neorg.text-objects.textobject.heading.outer)', { desc = 'Select heading' })
                    larp.fn.map({ 'n', 'x' }, '<localleader>T', '<Plug>(neorg.qol.todo-items.todo.task-cycle)', { desc = 'Cycle through Task Modes' })
                    larp.fn.map({ 'i', 'x', 'n' }, '<S-CR>', '<Plug>(neorg.itero.next-iteration)', { desc = 'Continue Current Object' })
                    larp.fn.map({ 'i', 'x', 'n' }, '<C-S-f>', '<Plug>(neorg.itero.next-iteration)', { desc = 'Continue Current Object' })
                    larp.fn.map('', '<localleader>Tc', '<cmd>Neorg toggle-concealer<cr>', { desc = 'Toggle Concealer' })
                end,
            })
        end,
    },
    {
        'epwalsh/obsidian.nvim',
        version = '*', -- recommended, use latest release instead of latest commit
        lazy = true,
        ft = 'markdown',
        -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
        -- event = {
        --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
        --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
        --   "BufReadPre path/to/my-vault/**.md",
        --   "BufNewFile path/to/my-vault/**.md",
        -- },
        dependencies = {
            -- Required.
            'nvim-lua/plenary.nvim',

            -- see below for full list of optional dependencies 👇
        },
        opts = {
            workspaces = {
                {
                    name = 'personal',
                    path = '~/vaults/personal',
                },
                {
                    name = 'work',
                    path = '~/vaults/work',
                },
            },

            -- see below for full list of options 👇
        },
        enabled = false,
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
        'nvim-orgmode/orgmode',
        enabled = false,
        dependencies = {
            'akinsho/org-bullets.nvim',
            'chipsenkbeil/org-roam.nvim',
        },
        event = 'VeryLazy',
        ft = { 'org' },
        config = function()
            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = '~/orgfiles/**/*',
                org_default_notes_file = '~/orgfiles/refile.org',
            })

            -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
            -- add ~org~ to ignore_install
            -- require('nvim-treesitter.configs').setup({
            --   ensure_installed = 'all',
            --   ignore_install = { 'org' },
            -- })

            require('org-bullets').setup({})

            require('org-roam').setup({
                directory = '~/org_roam_files',
            })
        end,
    },
    {
        'danymat/neogen',
        config = function()
            require('neogen').setup({ snippet_engine = 'luasnip' })
            local opts = { noremap = true, silent = true }
            vim.api.nvim_set_keymap('n', '<Leader>nf', ":lua require('neogen').generate()<CR>", opts)
        end,
        -- Uncomment next line if you want to follow only stable versions
        -- version = "*"
    },
    {
        'kristijanhusak/vim-dadbod-ui',
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
}

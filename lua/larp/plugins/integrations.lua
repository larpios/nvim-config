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
            local my_workspaces = {
                default = '~/notes/norgs',
                personal = '~/notes/norgs/personal',
                work = '~/notes/norgs/work',
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
                    ['core.concealer'] = {},
                    ['core.completion'] = {
                        config = {
                            name = '[Neorg]',
                            engine = 'nvim-cmp',
                        },
                    }, -- Load all the default modules
                    ['core.integrations.nvim-cmp'] = {},
                    ['core.integrations.treesitter'] = {},
                    ['core.integrations.telescope'] = {
                        config = {
                            insert_file_link = {
                                show_title_preview = true,
                            },
                        },
                    },
                    ['core.presenter'] = {
                        config = {
                            zen_mode = 'zen-mode',
                        },
                    },
                    ['core.export'] = {
                        config = {
                            path = '~/norgs/exports',
                            export_dir = '<export-dir>/<language>-export',
                        },
                    },
                    ['core.export.markdown'] = {},
                    ['core.fs'] = {},
                    ['core.neorgcmd'] = {},
                    ['core.ui'] = {},
                    ['core.neorgcmd.commands.return'] = {},
                    ['core.tempus'] = {},
                    ['core.syntax'] = {},
                    ['core.ui.calendar'] = {},
                    ['core.summary'] = {
                        config = {
                            strategy = 'default',
                        },
                    },
                    ['core.highlights'] = {},
                    ['core.clipboard'] = {},
                    ['core.queries.native'] = {},
                    ['core.todo-introspector'] = {},
                    ['core.storage'] = {
                        config = {
                            vim.fn.stdpath('data') .. '/neorg.mpack',
                        },
                    },
                    ['core.text-objects'] = {},
                },
            })
            larp.fn.map('n', '<leader>no', '<cmd>Neorg<CR>', { noremap = true, silent = true })
            larp.fn.map('n', '<leader>nw', function()
                vim.ui.select(vim.tbl_keys(my_workspaces), { prompt = 'Workspace: ' }, function(input)
                    vim.cmd('Neorg workspace ' .. input)
                end)
            end, { noremap = true, silent = true })

            larp.fn.map('n', '<leader>nfh', '<Plug>(neorg.telescope.search_headings)', { desc = 'Find Norg Headings' })
            larp.fn.map('n', '<leader>nff', '<Plug>(neorg.telescope.find_norg_files)', { desc = 'Find Norg Files' })
            larp.fn.map('n', '<leader>nfb', '<Plug>(neorg.telescope.backlinks.file_backlinks)', { desc = 'Find Backlinks' })
            larp.fn.map('n', '<leader>nfB', '<Plug>(neorg.telescope.backlinks.header_backlinks)', { desc = 'Find Header Backlinks' })
            larp.fn.map('n', '<localleader>nil', '<Plug>(neorg.telescope.insert_file_link)', { desc = 'Insert File Link' })
            larp.fn.map('n', '<localleader>nil', '<Plug>(neorg.telescope.insert_link)', { desc = 'Insert Link' })
            larp.fn.map({ 'i', 'x', 'n' }, '<C-@>', '<C-Space>', { noremap = true, silent = true })
            larp.fn.map(
                { 'i', 'x', 'n' },
                '<C-Space>',
                '<Plug>(neorg.itero.next-iteration)',
                { desc = 'Continue Current Object', noremap = true, silent = true }
            )

            vim.api.nvim_create_autocmd('Filetype', {
                pattern = 'norg',
                callback = function()
                    vim.o.conceallevel = 3
                    larp.fn.map('n', '<up>', '<Plug>(neorg.text-objects.item-up)', { desc = 'Move item up' })
                    larp.fn.map('n', '<down>', '<Plug>(neorg.text-objects.item-down)', { desc = 'Move item down' })
                    larp.fn.map({ 'o', 'x' }, 'iH', '<Plug>(neorg.text-objects.textobject.heading.inner)', { desc = 'Select heading' })
                    larp.fn.map({ 'o', 'x' }, 'aH', '<Plug>(neorg.text-objects.textobject.heading.outer)', { desc = 'Select heading' })
                    larp.fn.map({ 'n', 'x' }, '<localleader>T', '<Plug>(neorg.qol.todo-items.todo.task-cycle)', { desc = 'Cycle through Task Modes' })
                    larp.fn.map({ 'i', 'x', 'n' }, '<C-@>', '<C-Space>')
                    larp.fn.map({ 'i', 'x', 'n' }, '<C-Space>', '<Plug>(neorg.itero.next-iteration)', { desc = 'Continue Current Object' })
                    larp.fn.map({ 'i', 'x', 'n' }, '<C-S-a>', '<Plug>(neorg.itero.next-iteration)', { desc = 'Continue Current Object' })
                    larp.fn.map('', '<localleader>Tc', '<cmd>Neorg toggle-concealer<cr>', { desc = 'Toggle Concealer' })
                end,
            })
        end,
    },
    {
        'epwalsh/obsidian.nvim',
        enabled = false,
        priority = 1000,
        version = '*', -- recommended, use latest release instead of latest commit
        dependencies = {
            'nvim-lua/plenary.nvim',
            'hrsh7th/nvim-cmp',
            'ibhagwan/fzf-lua',
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {
            workspaces = {
                {
                    name = 'personal',
                    path = '~/obsidian-vault/personal',
                },
                {
                    name = 'work',
                    path = '~/obsidian-vault/work',
                },
            },
            templates = {
                folder = 'Templates',
            },
            daily_notes = {
                folder = 'journal',
            },
            completion = {
                nvim_cmp = true,
                min_char = 2,
            },
        },
        config = function(_, opts)
            local obsidian = require('obsidian')
            obsidian.setup(opts)
            require('nvim-treesitter.configs').setup({
                ensure_installed = { 'markdown', 'markdown_inline' },
                highlight = {
                    enable = true,
                },
            })

            local vault_path = '~/obsidian-vault'

            local workspaces = {
                {
                    name = 'personal',
                    path = vault_path .. '/personal',
                },
                {
                    name = 'work',
                    path = vault_path .. '/work',
                },
            }

            larp.fn.map('n', '<leader>Ow', function()
                vim.ui.select(larp.fn.tbl_get_by_key(workspaces, 'name'), {
                    prompt = 'Choose your obsidian vault',
                }, function(_, idx)
                    vim.cmd('edit ' .. workspaces[idx]['path'])
                end)
            end, { desc = 'Open Obisdian Workspace' })

            larp.fn.map('n', '<leader>Of', '<cmd>ObsidianSearch<cr>', { desc = 'Search Obsidian Vault' })

            vim.api.nvim_create_autocmd({ 'BufEnter' }, {
                desc = 'Enter Obsidian Vault',
                pattern = '' .. vault_path .. '.*',
                callback = function()
                    vim.o.conceallevel = 2
                end,
            })
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
        'nvim-orgmode/orgmode',
        event = 'VeryLazy',
        ft = { 'org' },
        config = function()
            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = '~/notes/orgs/**/*',
                org_default_notes_file = '~/notes/orgs/refile.org',
            })
            -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
            -- add ~org~ to ignore_install
            -- require('nvim-treesitter.configs').setup({
            --   ensure_installed = 'all',
            --   ignore_install = { 'org' },
            -- })
        end,
    },
    {
        'chipsenkbeil/org-roam.nvim',
        tag = '0.1.0',
        dependencies = { 'nvim-orgmode/orgmode' },
        config = function()
            require('org-roam').setup({
                directory = '~/org_roam_files',
                -- optional
                org_files = {
                    '~/notes/orgs',
                },
            })
        end,
    },
}

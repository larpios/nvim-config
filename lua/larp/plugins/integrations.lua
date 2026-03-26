return {
    {
        'iamcco/markdown-preview.nvim',
        cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
        ft = { 'markdown' },
        build = function()
            vim.fn['mkdp#util#install']()
        end,
        keys = {
            { '<leader>mds', '<cmd>MarkdownPreview<cr>',                             desc = 'Start Markdown Preview' },
            { '<leader>mdS', '<cmd>MarkdownPreviewStop<cr>',                         desc = 'Stop Markdown Preview' },
            { '<leader>mdr', '<cmd>MarkdownPreviewStop<cr><cmd>MarkdownPreview<cr>', desc = 'Restart Markdown Preview' },
        },
        config = function()
            vim.g.mkdp_preview_options = {
                uml = {
                    imageFormat = 'svg',
                },
            }
            vim.g.mkdp_theme = 'dark'
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
            local presets = require('markview.presets')
            require('markview').setup({
                preview = {
                    icon_provider = 'mini',
                },
                markdown = {
                    enable = true,
                    headings = presets.headings.arrowed,
                    horizontal_rules = presets.horizontal_rules.arrowed,
                    tables = presets.tables.rounded,
                },
                block = {
                    enable = true,
                },
                inline = {
                    enable = true,
                },
                html = {
                    enable = true,
                },
                latex = {
                    enable = true,
                },
                yaml = {
                    enable = true,
                },
            })
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
                },
            },
        },
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'echasnovski/mini.nvim',
            {
                'epwalsh/obsidian.nvim',
                optional = true,
                config = function()
                    require('obsidian').get_client().opts.ui.enable = false
                    vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces()['ObsidianUI'], 0, -1)
                end,
            }

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
            { '<leader>no',       '<cmd>Neorg<CR>',                                     desc = 'Open Neorg',           mode = 'n' },
            { '<leader>nw',       desc = 'Open Neorg Workspace' },
            { '<leader>nfh',      '<Plug>(neorg.telescope.search_headings)',            desc = 'Find Norg Headings' },
            { '<leader>nff',      '<Plug>(neorg.telescope.find_norg_files)',            desc = 'Find Norg Files' },
            { '<leader>nfb',      '<Plug>(neorg.telescope.backlinks.file_backlinks)',   desc = 'Find Backlinks' },
            { '<leader>nfB',      '<Plug>(neorg.telescope.backlinks.header_backlinks)', desc = 'Find Header Backlinks' },
            { '<localleader>niL', '<Plug>(neorg.telescope.insert_file_link)',           desc = 'Insert File Link' },
            { '<localleader>nil', '<Plug>(neorg.telescope.insert_link)',                desc = 'Insert Link' },
            { '<C-@>',            '<C-Space>',                                          mode = { 'i', 'x', 'n' },      desc = 'Continue Current Object' },
            { '<C-Space>',        '<Plug>(neorg.itero.next-iteration)',                 mode = { 'i', 'x', 'n' },      desc = 'Continue Current Object' },
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
                    ['core.autocommands'] = {},
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

            vim.api.nvim_create_autocmd('Filetype', {
                pattern = 'norg',
                callback = function()
                    vim.o.conceallevel = 3
                    vim.keymap.set('n', '<up>', '<Plug>(neorg.text-objects.item-up)', { desc = 'Move item up' })
                    vim.keymap.set('n', '<down>', '<Plug>(neorg.text-objects.item-down)', { desc = 'Move item down' })
                    vim.keymap.set({ 'o', 'x' }, 'iH', '<Plug>(neorg.text-objects.textobject.heading.inner)',
                        { desc = 'Select heading' })
                    vim.keymap.set({ 'o', 'x' }, 'aH', '<Plug>(neorg.text-objects.textobject.heading.outer)',
                        { desc = 'Select heading' })
                    vim.keymap.set({ 'n', 'x' }, '<localleader>T', '<Plug>(neorg.qol.todo-items.todo.task-cycle)',
                        { desc = 'Cycle through Task Modes' })
                    vim.keymap.set({ 'i', 'x', 'n' }, '<C-@>', '<C-Space>')
                    vim.keymap.set({ 'i', 'x', 'n' }, '<S-CR>', '<Plug>(neorg.itero.next-iteration)',
                        { desc = 'Continue Current Object' })
                    vim.keymap.set({ 'i', 'x', 'n' }, '<C-Space>', '<Plug>(neorg.itero.next-iteration)',
                        { desc = 'Continue Current Object' })
                    vim.keymap.set({ 'i', 'x', 'n' }, '<C-S-a>', '<Plug>(neorg.itero.next-iteration)',
                        { desc = 'Continue Current Object' })
                    vim.keymap.set('', '<localleader>Tc', '<cmd>Neorg toggle-concealer<cr>',
                        { desc = 'Toggle Concealer' })
                end,
            })
        end,
    },
    {
        'nvim-orgmode/orgmode',
        event = 'VeryLazy',
        ft = { 'org' },
        keys = {
            {
                '<leader>oo',
                function()
                    require('orgmode').setup(); vim.cmd('e ~/obsidian-vault/')
                end,
                desc = 'Open Orgmode'
            },
            { '<leader>of', function() require('fzf-lua').files({ cwd = '~/obsidian-vault/' }) end, desc = 'Find Org Files' },
            {
                '<leader>oj',
                function()
                    local org_path = '~/obsidian-vault/'
                    local today = os.date('*t')
                    local journal = org_path ..
                        '/journal/' .. today.year .. '/' .. today.month .. '/' .. today.day .. '.org'
                    if vim.fn.filereadable(vim.fn.expand(journal)) == 0 then
                        vim.cmd('silent !mkdir -p ' .. org_path .. '/journal/' .. today.year .. '/' .. today.month)
                        vim.cmd('silent !touch ' .. journal)
                    end
                    vim.cmd('e ' .. journal)
                end,
                desc = 'Open Org Journal',
            },
        },
        config = function()
            local org_path = '~/obsidian-vault/'
            require('orgmode').setup({
                org_agenda_files = org_path .. '/**/*',
                org_default_notes_file = org_path .. 'refile.org',
                org_startup_indented = true,
                org_fold_enable = false,
                org_startup_folded = 'showeverything',
                mappings = {
                    disable_all = true,
                },
            })
            -- Experimental LSP support
            vim.lsp.enable('org')
        end,
    },
    {
        'epwalsh/obsidian.nvim',
        enabled = false,
        priority = 1000,
        cmd = {
            'ObsidianNew',
            'ObsidianOpen',
            'ObsidianSearch',
        },
        keys = {
            { '<leader>Off', '<cmd>ObsidianQuickSwitch<cr>', mode = 'n', desc = 'Search Obsidian Vault' },
            { '<leader>Ogg', '<cmd>ObsidianSearch<cr>',      mode = 'n', desc = 'Grep Obsidian Vault' },
            { '<leader>Ot',  '<cmd>ObsidianTOC<cr>',         mode = 'n', desc = 'Search Obsidian TOC' },
            { '<leader>Oft', '<cmd>ObsidianTags<cr>',        mode = 'n', desc = 'Find Obsidian Tags' },
            { '<leader>Oj',  '<cmd>ObsidianDailies<cr>',     mode = 'n', desc = 'Obsidian Journal' },
            {
                '<leader>Ofw',
                function()
                    local obsidian = require('obsidian')
                    local client = obsidian.get_client()
                    local workspaces = client.opts.workspaces
                    local names = {}
                    for _, w in ipairs(workspaces) do
                        table.insert(names, w.name)
                    end
                    vim.ui.select(names, {
                        prompt = 'Choose your obsidian vault',
                    }, function(_, idx)
                        if idx then
                            vim.cmd('edit ' .. vim.fn.fnameescape(workspaces[idx]['path']))
                        end
                    end)
                end,
                mode = 'n',
                desc = 'Search Obsidian Workspace',
            },
            {
                '<leader>Op',
                function()
                    local obsidian = require('obsidian')
                    local client = obsidian.get_client()
                    local path = vim.fn.expand(client.opts.workspaces[1].path)
                    vim.system({ 'sh', '-c', 'jj git fetch' }, { cwd = path, text = true }, function(obj)
                        vim.schedule(function()
                            if obj.code == 0 then
                                vim.notify('Obsidian Pull: Success', vim.log.levels.INFO)
                            else
                                vim.notify('Obsidian Pull Failed:\n' .. (obj.stderr or obj.stdout or ''),
                                    vim.log.levels.ERROR)
                            end
                        end)
                    end)
                end,
                mode = 'n',
                desc = 'Obsidian Pull',
            },
            {
                '<leader>Os',
                function()
                    local obsidian = require('obsidian')
                    local client = obsidian.get_client()
                    local path = vim.fn.expand(client.opts.workspaces[1].path)
                    local now = os.date('%Y-%m-%d %H:%M:%S')

                    -- Check for conflicts first, then push
                    local cmd = 'jj git fetch && '
                        .. 'if jj log -r @ --no-graph -T "conflict" | grep -q "true"; then '
                        .. 'echo "Conflicts detected!" >&2; exit 1; '
                        .. 'else '
                        .. 'jj bookmark move main --to @ && jj commit -m "Update '
                        .. now
                        .. '" && jj git push; '
                        .. 'fi'

                    vim.system({ 'sh', '-c', cmd }, { cwd = path, text = true }, function(obj)
                        vim.schedule(function()
                            if obj.code == 0 then
                                vim.notify('Obsidian Push: Success\nUpdate ' .. now, vim.log.levels.INFO)
                            else
                                local err = obj.stderr or obj.stdout or ''
                                if err:match('Conflicts detected!') then
                                    vim.notify(
                                        'Obsidian Push Aborted: Conflicts detected! Please resolve before pushing.',
                                        vim.log.levels.WARN)
                                else
                                    vim.notify('Obsidian Push Failed:\n' .. err, vim.log.levels.ERROR)
                                end
                            end
                        end)
                    end)
                end,
                mode = 'n',
                desc = 'Commit and Push Obsidian Vault',
            },
        },
        version = '*', -- recommended, use latest release instead of latest commit
        dependencies = {
            'nvim-lua/plenary.nvim',
            'hrsh7th/nvim-cmp',
            'ibhagwan/fzf-lua',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            local obsidian = require('obsidian')

            local workspace_candidates = {
                {
                    name = 'default',
                    path = '~/obsidian-vault',
                },
                {
                    name = 'fallback',
                    path = '~/.dotfiles/obsidian-vault',
                },
            }

            local opts = {
                workspaces = {},
                templates = {
                    folder = 'Templates',
                },
                daily_notes = {
                    folder = 'journal',
                    template = 'Daily Template',
                },
                completion = {
                    nvim_cmp = true,
                    min_char = 2,
                },
                follow_url_func = function(url)
                    vim.fn.jobstart({ 'xdg-open', url })
                end,

                mappings = {
                    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
                    ['gf'] = {
                        action = function()
                            return require('obsidian').util.gf_passthrough()
                        end,
                        opts = { noremap = false, expr = true, buffer = true },
                    },
                    -- Toggle check-boxes.
                    ['<leader>ch'] = {
                        action = function()
                            return require('obsidian').util.toggle_checkbox()
                        end,
                        opts = { buffer = true },
                    },
                    -- Smart action depending on context, either follow link or toggle checkbox.
                    ['<cr>'] = {
                        action = function()
                            return require('obsidian').util.smart_action()
                        end,
                        opts = { buffer = true, expr = true },
                    },
                },
                ui = {
                    enable = true,
                    update_debounce = 200,  -- update delay after a text change (in milliseconds)
                    max_file_length = 5000, -- disable UI features for files with more than this many lines
                    checkboxes = {
                        [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
                        ['x'] = { char = '', hl_group = 'ObsidianDone' },
                        ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
                        ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
                        ['!'] = { char = '', hl_group = 'ObsidianImportant' },
                    },
                },
            }

            for _, candidate in ipairs(workspace_candidates) do
                if vim.fn.isdirectory(vim.fn.expand(candidate.path)) == 1 then
                    opts.workspaces[#opts.workspaces + 1] = candidate
                end
            end

            obsidian.setup(opts)

            vim.o.conceallevel = 2

            require('nvim-treesitter').setup({
                ensure_installed = { 'markdown', 'markdown_inline' },
                highlight = {
                    enable = true,
                },
            })

            vim.api.nvim_create_autocmd({ 'BufEnter' }, {
                desc = 'Enter Obsidian Vault',
                pattern = '~/notes/obsidian/*',
                callback = function()
                    vim.o.conceallevel = 2
                end,
            })
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
        opts = {
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
        },
    },
    {
        'mrjones2014/smart-splits.nvim',
        version = '>=1.0.0',
        lazy = false,
        opts = {
            multiplexer_integration = true,
            zellij_move_focus_or_tab = true,
        },
        keys = {
            {
                '<A-h>',
                function()
                    require('smart-splits').resize_left()
                end,
            },
            {
                '<A-j>',
                function()
                    require('smart-splits').resize_down()
                end,
            },
            {
                '<A-k>',
                function()
                    require('smart-splits').resize_up()
                end,
            },
            {
                '<A-l>',
                function()
                    require('smart-splits').resize_right()
                end,
            },
            {
                '<C-h>',
                function()
                    require('smart-splits').move_cursor_left()
                end,
            },
            {
                '<C-j>',
                function()
                    require('smart-splits').move_cursor_down()
                end,
            },
            {
                '<C-k>',
                function()
                    require('smart-splits').move_cursor_up()
                end,
            },
            {
                '<C-l>',
                function()
                    require('smart-splits').move_cursor_right()
                end,
            },
            {
                '<C-\\>',
                function()
                    require('smart-splits').move_cursor_previous()
                end,
            },
            {
                '<leader><leader>h',
                function()
                    require('smart-splits').swap_buf_left()
                end,
            },
            {
                '<leader><leader>j',
                function()
                    require('smart-splits').swap_buf_down()
                end,
            },
            {
                '<leader><leader>k',
                function()
                    require('smart-splits').swap_buf_up()
                end,
            },
            {
                '<leader><leader>l',
                function()
                    require('smart-splits').swap_buf_right()
                end,
            },
        },
    },
    {
        'hat0uma/csvview.nvim',
        ft = { 'csv' },
        ---@module "csvview"
        ---@type CsvView.Options
        opts = {
            parser = { comments = { '#', '//' } },
            keymaps = {
                -- Text objects for selecting fields
                textobject_field_inner = { 'if', mode = { 'o', 'x' } },
                textobject_field_outer = { 'af', mode = { 'o', 'x' } },
                -- Excel-like navigation:
                -- Use <Tab> and <S-Tab> to move horizontally between fields.
                -- Use <Enter> and <S-Enter> to move vertically between rows and place the cursor at the end of the field.
                -- Note: In terminals, you may need to enable CSI-u mode to use <S-Tab> and <S-Enter>.
                jump_next_field_end = { '<Tab>', mode = { 'n', 'v' } },
                jump_prev_field_end = { '<S-Tab>', mode = { 'n', 'v' } },
                jump_next_row = { '<Enter>', mode = { 'n', 'v' } },
                jump_prev_row = { '<S-Enter>', mode = { 'n', 'v' } },
            },
        },
        cmd = { 'CsvViewEnable', 'CsvViewDisable', 'CsvViewToggle' },
    },
}

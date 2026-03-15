return {
    {
        -- # Provides various useful modules
        'echasnovski/mini.nvim',
        version = '*',
        lazy = false,
        config = function()
            require('custom.mini')
        end,
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            bigfile = { enabled = true },
            bufdelete = { enabled = true }, -- Delete buffers without disrupting window layout.
            indent = { enabled = true },
            input = { enabled = true }, -- Better `vim.ui.input`.
            -- dashboard = {},
            notifier = { enabled = true },
            toggle = { enabled = true },
            quickfile = { enabled = true },
            git = { enabled = true }, -- Git utilities.
            gh = { enabled = true },
            gitbrowse = { enabled = true }, -- Open the repo of the active file in the browser.
            statuscolumn = { enabled = true },
            scope = { enabled = true }, -- Scope detection based on treesitter or indent.
            words = { enabled = true },
            picker = {
                enabled = true,
                formatters = {
                    file = {
                        filename_first = true,
                        truncate = 10000,
                    },
                },
                win = {
                    input = {
                        keys = {
                            ['<a-.>'] = { 'toggle_hidden', mode = { 'i', 'n' } },
                        },
                    },
                },
            },
            lazygit = { enabled = true },
            scratch = { enabled = true },
            zen = { enabled = true },
            styles = {
                notification = {
                    wo = {
                        wrap = true,
                    },
                },
            },
        },
        keys = {

            -- Picker
            {
                '<leader>ff',
                function()
                    Snacks.picker.smart()
                end,
                desc = '[Snacks.Picker] Files (Smart)',
                silent = true,
            },
            {
                '<leader>fF',
                function()
                    Snacks.picker.files()
                end,
                desc = '[Snacks.Picker] Files',
                silent = true,
            },
            {
                '<leader>fc',
                function()
                    Snacks.picker.files({
                        cwd = vim.fn.stdpath('config'),
                    })
                end,
                desc = '[Snacks.Picker] Neovim Config Files',
                silent = true,
            },
            {
                '<leader>fC',
                function()
                    Snacks.picker.commands()
                end,
                desc = '[Snacks.Picker] Commands',
                silent = true,
            },
            {
                '<leader>fw',
                function()
                    Snacks.picker.files({
                        live = true,
                        search = vim.fn.expand('<cWORD>'),
                    })
                end,
                mode = { 'n', 'x' },
                desc = '[Snacks.Picker] Files Under Cursor',
                silent = true,
            },
            {
                '<leader>fa',
                function()
                    Snacks.picker.autocmds()
                end,
                desc = '[Snacks.Picker] Autocmds',
                silent = true,
            },
            {
                '<leader>fr',
                function()
                    Snacks.picker.recent()
                end,
                desc = '[Snacks.Picker] Recent',
                silent = true,
            },
            {
                '<leader>fs',
                function()
                    Snacks.picker.lsp_symbols()
                end,
                desc = '[Snacks.Picker] LSP Symbols',
                silent = true,
            },
            {
                '<leader>fS',
                function()
                    Snacks.picker.lsp_workspace_symbols()
                end,
                desc = '[Snacks.Picker] LSP Workspace Symbols',
                silent = true,
            },
            {
                '<leader>fb',
                function()
                    Snacks.picker.buffers()
                end,
                desc = '[Snacks.Picker] Buffers',
                silent = true,
            },
            {
                '<leader>fh',
                function()
                    Snacks.picker.help()
                end,
                desc = '[Snacks.Picker] Help File',
                silent = true,
            },
            {
                '<leader>fl',
                function()
                    Snacks.picker.lazy()
                end,
                desc = '[Snacks.Picker] Lazy Plugin Specs File',
                silent = true,
            },

            -- Search
            {
                '<leader>sg',
                function()
                    Snacks.picker.grep()
                end,
                desc = '[Snacks.Picker] Grep',
                silent = true,
            },
            {
                '<leader>s"',
                function()
                    Snacks.picker.registers()
                end,
                desc = '[Snacks.Picker] Registers',
                silent = true,
            },
            {
                '<leader>sn',
                function()
                    Snacks.picker.notifications()
                end,
                desc = '[Snacks.Picker] Notifications',
                silent = true,
            },
            {
                '<leader>s:',
                function()
                    Snacks.picker.command_history()
                end,
                desc = '[Snacks.Picker] Command History',
                silent = true,
            },
            {
                '<leader>sc',
                function()
                    Snacks.picker.grep({
                        cwd = vim.fn.stdpath('config'),
                    })
                end,
                desc = '[Snacks.Picker] Grep',
                silent = true,
            },
            {
                '<leader>sq',
                function()
                    Snacks.picker.qfist()
                end,
                desc = '[Snacks.Picker] Quickfix List',
                silent = true,
            },
            {
                '<leader>sp',
                function()
                    Snacks.picker.pick()
                end,
                desc = '[Snacks.Picker] Picker Commands',
                silent = true,
            },
            {
                '<leader>sk',
                function()
                    Snacks.picker.keymaps()
                end,
                desc = '[Snacks.Picker] Keymaps',
                silent = true,
            },
            {
                '<leader>sl',
                function()
                    Snacks.picker.loclist()
                end,
                desc = '[Snacks.Picker] Location List',
                silent = true,
            },
            {
                '<leader>sM',
                function()
                    Snacks.picker.man()
                end,
                desc = '[Snacks.Picker] Man Pages',
                silent = true,
            },
            {
                '<leader>sd',
                function()
                    Snacks.picker.diagnostics()
                end,
                desc = '[Snacks.Picker] Diagnostics',
                silent = true,
            },
            {
                '<leader>sD',
                function()
                    Snacks.picker.diagnostics_buffer()
                end,
                desc = '[Snacks.Picker] Buffer Diagnostics',
                silent = true,
            },
            {
                '<leader>sm',
                function()
                    Snacks.picker.marks()
                end,
                desc = '[Snacks.Picker] Marks',
                silent = true,
            },
            {
                '<leader>sb',
                function()
                    Snacks.picker.lines()
                end,
                desc = '[Snacks.Picker] Buffer Lines',
                silent = true,
            },
            {
                '<leader>sB',
                function()
                    Snacks.picker.grep_buffers()
                end,
                desc = '[Snacks.Picker] Grep Open Buffers',
                silent = true,
            },
            {
                '<leader>sw',
                function()
                    Snacks.picker.grep_word({
                        args = { '--hidden', '--follow', '--glob', '!*/.git/*', '--no-ignore' },
                    })
                end,
                mode = {
                    'n',
                    'x',
                },
                desc = '[Snacks.Picker] Grep Word',
                silent = true,
            },
            {
                '<leader>sH',
                function()
                    Snacks.picker.highlights()
                end,
                desc = '[Snacks.Picker] Highlights',
                silent = true,
            },
            {
                '<leader>si',
                function()
                    Snacks.picker.icons()
                end,
                desc = '[Snacks.Picker] Icons',
                silent = true,
            },
            {
                '<leader>su',
                function()
                    Snacks.picker.undo()
                end,
                desc = '[Snacks.Picker] Undo History',
            },
            {
                '<leader>s.',
                function()
                    Snacks.picker.resume()
                end,
                desc = '[Snacks.Picker] Resume',
            },
            {
                '<leader>s/',
                function()
                    Snacks.picker.search_history({
                        args = { '--hidden', '--follow', '--glob', '!*/.git/*', '--no-ignore' },
                    })
                end,
                desc = '[Snacks.Picker] Grep Word',
                silent = true,
            },

            -- LSP
            {
                'gd',
                function()
                    Snacks.picker.lsp_definitions()
                end,
                desc = 'Goto Definition',
            },
            {
                'gD',
                function()
                    Snacks.picker.lsp_declarations()
                end,
                desc = 'Goto Declaration',
            },
            {
                'gr',
                function()
                    Snacks.picker.lsp_references()
                end,
                nowait = true,
                desc = 'References',
            },
            {
                'gI',
                function()
                    Snacks.picker.lsp_implementations()
                end,
                desc = 'Goto Implementation',
            },
            {
                'gy',
                function()
                    Snacks.picker.lsp_type_definitions()
                end,
                desc = 'Goto T[y]pe Definition',
            },
            {
                'gai',
                function()
                    Snacks.picker.lsp_incoming_calls()
                end,
                desc = 'C[a]lls Incoming',
            },
            {
                'gao',
                function()
                    Snacks.picker.lsp_outgoing_calls()
                end,
                desc = 'C[a]lls Outgoing',
            },
            {
                '<leader>ss',
                function()
                    Snacks.picker.lsp_symbols()
                end,
                desc = 'LSP Symbols',
            },
            {
                '<leader>sS',
                function()
                    Snacks.picker.lsp_workspace_symbols()
                end,
                desc = 'LSP Workspace Symbols',
            },

            -- Lazygit
            {
                '<leader>gg',
                function()
                    Snacks.lazygit()
                end,
                desc = '[Snacks.Lazygit] Lazygit',
                silent = true,
            },

            -- Scratch
            {
                '<leader>St',
                function()
                    Snacks.scratch()
                end,
                desc = '[Snacks.Scratch] Open Scratch Buffer',
                silent = true,
            },
            {
                '<leader>Ss',
                function()
                    Snacks.scratch.select()
                end,
                desc = '[Snacks.Scratch] Select Scratch Buffer',
                silent = true,
            },

            -- Git
            {
                '<leader>gd',
                function()
                    Snacks.picker.git_diff()
                end,
                desc = '[Snacks.Picker] Git Diff',
                silent = true,
            },
            {
                '<leader>gl',
                function()
                    Snacks.picker.git_log()
                end,
                desc = '[Snacks.Picker] Git Log',
                silent = true,
            },
            {
                '<leader>gL',
                function()
                    Snacks.picker.git_log_line()
                end,
                desc = '[Snacks.Picker] Git Log Line',
                silent = true,
            },
            {
                '<leader>gs',
                function()
                    Snacks.picker.git_status()
                end,
                desc = '[Snacks.Picker] Git Status',
                silent = true,
            },
            {
                '<leader>gS',
                function()
                    Snacks.picker.git_stash()
                end,
                desc = '[Snacks.Picker] Git Stash',
                silent = true,
            },
            {
                '<leader>gf',
                function()
                    Snacks.picker.git_log_file()
                end,
                desc = '[Snacks.Picker] Git Log File',
                silent = true,
            },
            {
                '<leader>gb',
                function()
                    Snacks.picker.git_branches()
                end,
                desc = '[Snacks.Picker] Git Branches',
                silent = true,
            },
            {
                '<leader>gB',
                function()
                    Snacks.git.blame_line()
                end,
                mode = { 'n', 'x' },
                desc = '[Snacks.Git] Blame Line',
                silent = true,
            },
            {
                '<leader>gr',
                function()
                    vim.notify('Git root: ' .. Snacks.git.get_root())
                end,
                mode = { 'n', 'x' },
                desc = '[Snacks.Git] Get Root',
                silent = true,
            },

            -- Notifier
            {
                '<leader>nh',
                function()
                    Snacks.notifier.show_history()
                end,
                desc = '[Snacks.Notifier] Show History',
                silent = true,
            },
            {
                '<leader>nd',
                function()
                    Snacks.notifier.hide()
                end,
                desc = '[Snacks.Notifier] Notification Dismiss',
                silent = true,
            },

            -- Bufdelete
            {
                '<leader>bd',
                function()
                    Snacks.bufdelete.other()
                end,
                desc = '[Snacks.Bufdelete] Delete Other',
                silent = true,
            },

            -- Other
            {
                '<leader>crf',
                function()
                    Snacks.rename.rename_file()
                end,
                desc = '[Snacks.Rename] Rename File',
            },
            {
                '<c-/>',
                function()
                    Snacks.terminal()
                end,
                desc = '[Snacks.Terminal] Toggle Terminal',
            },
            {
                ']]',
                function()
                    Snacks.words.jump(vim.v.count1)
                end,
                desc = 'Next Reference',
                mode = { 'n', 't' },
            },
            {
                '[[',
                function()
                    Snacks.words.jump(-vim.v.count1)
                end,
                desc = 'Prev Reference',
                mode = { 'n', 't' },
            },
            {
                '<leader>,n',
                desc = 'Neovim News',
                function()
                    Snacks.win({
                        file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
                        width = 0.6,
                        height = 0.6,
                        wo = {
                            spell = false,
                            wrap = false,
                            signcolumn = 'yes',
                            statuscolumn = ' ',
                            conceallevel = 3,
                        },
                    })
                end,
            },
        },
        init = function()
            vim.api.nvim_create_autocmd('User', {
                pattern = 'VeryLazy',
                callback = function()
                    -- Setup some globals for debugging (lazy-loaded)
                    _G.dd = function(...)
                        Snacks.debug.inspect(...)
                    end
                    _G.bt = function()
                        Snacks.debug.backtrace()
                    end

                    -- Override print to use snacks for `:=` command
                    if vim.fn.has('nvim-0.11') == 1 then
                        vim._print = function(_, ...)
                            dd(...)
                        end
                    else
                        vim.print = _G.dd
                    end

                    -- Create some toggle mappings
                    Snacks.toggle.option('spell', { name = 'Spelling' }):map('<leader>us')
                    Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<leader>uw')
                    Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<leader>uL')
                    Snacks.toggle.diagnostics():map('<leader>ud')
                    Snacks.toggle.line_number():map('<leader>ul')
                    Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map('<leader>uc')
                    Snacks.toggle.treesitter():map('<leader>uT')
                    Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<leader>ub')
                    Snacks.toggle.inlay_hints():map('<leader>uh')
                    Snacks.toggle.indent():map('<leader>ug')
                    Snacks.toggle.dim():map('<leader>uD')
                    Snacks.toggle.animate():map('<leader>ua')
                    Snacks.toggle.profiler():map('<leader>up')
                end,
            })
        end,
        dependencies = {
            {
                'folke/todo-comments.nvim',
                optional = true,
                keys = {
                    {
                        '<leader>st',
                        function()
                            Snacks.picker.todo_comments()
                        end,
                        desc = 'Todo',
                    },
                    {
                        '<leader>sT',
                        function()
                            Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } })
                        end,
                        desc = 'Todo/Fix/Fixme',
                    },
                },
            },
        },
    },
}

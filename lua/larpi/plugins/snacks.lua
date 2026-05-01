local images = {
    'xqc.png',
    'quieres.png',
    'niko_shocked.png',
    'niko_pancake.png',
    'moist.png',
    'ralsei.png',
    'ralsei2.png',
    'juan.png',
    'cat_with_gun.png',
    'terry.png',
}

math.randomseed(os.time())
local logo = vim.fn.stdpath('config') .. '/images/' .. images[math.random(#images)]

return {
    'folke/snacks.nvim',
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        explorer = {
            replace_netrw = false,
            trash = true,
        },
        bigfile = { enabled = true },
        bufdelete = { enabled = true }, -- Delete buffers without disrupting window layout.
        dashboard = {
            pane_gap = 6,
            preset = {
                keys = {
                    { icon = ' ', key = 'f', desc = 'Find File', action = ":lua Snacks.dashboard.pick('files')" },
                    { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
                    { icon = ' ', key = 'e', desc = 'Explorer', action = ':lua Snacks.explorer()' },
                    { icon = '󱃪 ', key = 'o', desc = 'Oil', action = ':Oil' },
                    { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
                    { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
                    { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
                },
                header = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
            },
            sections = {
                {
                    section = 'terminal',
                    cmd = 'chafa ' .. logo .. ' --symbols all --view-size 60x35 --align center,center',
                    height = 35,
                },
                {
                    pane = 2,
                    height = 35,
                    { section = 'header', padding = 4 },
                    {
                        section = 'keys',
                        gap = 1,
                        padding = 5,
                    },
                    { section = 'startup' },
                },
            },
        },
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
            ui_select = true,
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
        -- Explorer
        {
            '<leader>e',
            function()
                Snacks.explorer()
            end,
            desc = '[Snacks.Explorer] Explorer',
        },
        -- Picker
        {
            '<leader>ff',
            function()
                Snacks.picker.smart()
            end,
            desc = '[Snacks.Picker] Files (Smart)',
        },
        {
            '<leader>fF',
            function()
                Snacks.picker.files()
            end,
            desc = '[Snacks.Picker] Files',
        },
        {
            '<leader>fc',
            function()
                Snacks.picker.files({
                    cwd = vim.fn.stdpath('config'),
                })
            end,
            desc = '[Snacks.Picker] Neovim Config Files',
        },
        {
            '<leader>fC',
            function()
                Snacks.picker.commands()
            end,
            desc = '[Snacks.Picker] Commands',
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
        },
        {
            '<leader>fa',
            function()
                Snacks.picker.autocmds()
            end,
            desc = '[Snacks.Picker] Autocmds',
        },
        {
            '<leader>fr',
            function()
                Snacks.picker.recent()
            end,
            desc = '[Snacks.Picker] Recent',
        },
        {
            '<leader>fs',
            function()
                Snacks.picker.lsp_symbols()
            end,
            desc = '[Snacks.Picker] LSP Symbols',
        },
        {
            '<leader>fS',
            function()
                Snacks.picker.lsp_workspace_symbols()
            end,
            desc = '[Snacks.Picker] LSP Workspace Symbols',
        },
        {
            '<leader>fb',
            function()
                Snacks.picker.buffers()
            end,
            desc = '[Snacks.Picker] Buffers',
        },
        {
            '<leader>fh',
            function()
                Snacks.picker.help()
            end,
            desc = '[Snacks.Picker] Help File',
        },
        {
            '<leader>fh',
            function()
                Snacks.picker.help({ search = larpi.fn.get_highlighted_text() })
            end,
            desc = '[Snacks.Picker] Help File',
            mode = 'x',
        },
        {
            '<leader>ft',
            function()
                Snacks.picker.treesitter()
            end,
            desc = '[Snacks.Picker] Help File',
        },
        {
            '<leader>fT',
            function()
                Snacks.picker.todo_comments()
            end,
            desc = '[Snacks.Picker] Help File',
        },
        {
            '<leader>fl',
            function()
                Snacks.picker.lazy()
            end,
            desc = '[Snacks.Picker] Lazy Plugin Specs File',
        },

        -- Search
        {
            '<leader>sg',
            function()
                Snacks.picker.grep()
            end,
            desc = '[Snacks.Picker] Grep',
        },
        {
            '<leader>f"',
            function()
                Snacks.picker.registers()
            end,
            desc = '[Snacks.Picker] Registers',
        },
        {
            '<leader>fn',
            function()
                Snacks.picker.notifications()
            end,
            desc = '[Snacks.Picker] Notifications',
        },
        {
            '<leader>f:',
            function()
                Snacks.picker.command_history()
            end,
            desc = '[Snacks.Picker] Command History',
        },
        {
            '<leader>sc',
            function()
                Snacks.picker.grep({
                    cwd = vim.fn.stdpath('config'),
                })
            end,
            desc = '[Snacks.Picker] Grep Neovim Config',
        },
        {
            '<leader>fq',
            function()
                Snacks.picker.qflist()
            end,
            desc = '[Snacks.Picker] Quickfix List',
        },
        {
            '<leader>fp',
            function()
                Snacks.picker.pick()
            end,
            desc = '[Snacks.Picker] Picker Commands',
        },
        {
            '<leader>fk',
            function()
                Snacks.picker.keymaps()
            end,
            desc = '[Snacks.Picker] Keymaps',
        },
        {
            '<leader>fL',
            function()
                Snacks.picker.loclist()
            end,
            desc = '[Snacks.Picker] Location List',
        },
        {
            '<leader>fm',
            function()
                Snacks.picker.man()
            end,
            desc = '[Snacks.Picker] Man Pages',
        },
        {
            '<leader>fd',
            function()
                Snacks.picker.diagnostics()
            end,
            desc = '[Snacks.Picker] Diagnostics',
        },
        {
            '<leader>fD',
            function()
                Snacks.picker.diagnostics_buffer()
            end,
            desc = '[Snacks.Picker] Buffer Diagnostics',
        },
        {
            '<leader>fM',
            function()
                Snacks.picker.marks()
            end,
            desc = '[Snacks.Picker] Marks',
        },
        {
            '<leader>sb',
            function()
                Snacks.picker.lines()
            end,
            desc = '[Snacks.Picker] Buffer Lines',
        },
        {
            '<leader>sB',
            function()
                Snacks.picker.grep_buffers()
            end,
            desc = '[Snacks.Picker] Grep Open Buffers',
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
        },
        {
            '<leader>fH',
            function()
                Snacks.picker.highlights()
            end,
            desc = '[Snacks.Picker] Highlights',
        },
        {
            '<leader>fi',
            function()
                Snacks.picker.icons()
            end,
            desc = '[Snacks.Picker] Icons',
        },
        {
            '<leader>fu',
            function()
                Snacks.picker.undo()
            end,
            desc = '[Snacks.Picker] Undo History',
        },
        {
            '<leader>f.',
            function()
                Snacks.picker.resume()
            end,
            desc = '[Snacks.Picker] Resume',
        },
        {
            '<leader>fz',
            function()
                Snacks.picker.zoxide()
            end,
            desc = '[Snacks.Picker] Zoxide',
        },
        {
            '<leader>s/',
            function()
                Snacks.picker.search_history({
                    args = { '--hidden', '--follow', '--glob', '!*/.git/*', '--no-ignore' },
                })
            end,
            desc = '[Snacks.Picker] Grep Word',
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
            'grr',
            function()
                Snacks.picker.lsp_references()
            end,
            nowait = true,
            desc = 'References',
        },
        {
            'gri',
            function()
                Snacks.picker.lsp_implementations()
            end,
            desc = 'Goto Implementation',
        },
        {
            'grt',
            function()
                Snacks.picker.lsp_type_definitions()
            end,
            desc = 'Goto T[y]pe Definition',
        },
        {
            'grci',
            function()
                Snacks.picker.lsp_incoming_calls()
            end,
            desc = 'C[a]lls Incoming',
        },
        {
            'grco',
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
        },
        {
            '<leader>gc',
            function()
                local curr_dir = vim.fn.getcwd()

                -- Go to Neovim Config Directory and run Lazygit
                vim.cmd('cd ' .. vim.fn.stdpath('config'))
                Snacks.lazygit()

                -- Come back to the original directory
                vim.cmd('cd ' .. curr_dir)
            end,
            desc = '[Snacks.Lazygit] Lazygit in Neovim Config',
        },

        -- Scratch
        {
            '<leader>St',
            function()
                Snacks.scratch()
            end,
            desc = '[Snacks.Scratch] Open Scratch Buffer',
        },
        {
            '<leader>Ss',
            function()
                Snacks.scratch.select()
            end,
            desc = '[Snacks.Scratch] Select Scratch Buffer',
        },

        -- Git
        {
            '<leader>gd',
            function()
                Snacks.picker.git_diff()
            end,
            desc = '[Snacks.Picker] Git Diff',
        },
        {
            '<leader>gl',
            function()
                Snacks.picker.git_log()
            end,
            desc = '[Snacks.Picker] Git Log',
        },
        {
            '<leader>gL',
            function()
                Snacks.picker.git_log_line()
            end,
            desc = '[Snacks.Picker] Git Log Line',
        },
        {
            '<leader>gs',
            function()
                Snacks.picker.git_status()
            end,
            desc = '[Snacks.Picker] Git Status',
        },
        {
            '<leader>gS',
            function()
                Snacks.picker.git_stash()
            end,
            desc = '[Snacks.Picker] Git Stash',
        },
        {
            '<leader>gf',
            function()
                Snacks.picker.git_log_file()
            end,
            desc = '[Snacks.Picker] Git Log File',
        },
        {
            '<leader>gb',
            function()
                Snacks.picker.git_branches()
            end,
            desc = '[Snacks.Picker] Git Branches',
        },
        {
            '<leader>gB',
            function()
                Snacks.git.blame_line()
            end,
            mode = { 'n', 'x' },
            desc = '[Snacks.Git] Blame Line',
        },
        {
            '<leader>gr',
            function()
                vim.notify('Git root: ' .. Snacks.git.get_root())
            end,
            mode = { 'n', 'x' },
            desc = '[Snacks.Git] Get Root',
        },

        -- Notifier
        {
            '<leader>nh',
            function()
                Snacks.notifier.show_history()
            end,
            desc = '[Snacks.Notifier] Show History',
        },
        {
            '<leader>nd',
            function()
                Snacks.notifier.hide()
            end,
            desc = '[Snacks.Notifier] Notification Dismiss',
        },

        -- Bufdelete
        {
            '<leader>bd',
            function()
                local function get_visible_buffers() end
                Snacks.bufdelete.other()
            end,
            desc = '[Snacks.Bufdelete] Delete Other',
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
            '<c-t>',
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
            mode = { 'n', 'x' },
        },
        {
            '[[',
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = 'Prev Reference',
            mode = { 'n', 'x' },
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
                Snacks.toggle.zen():map('<leader>uz')
            end,
        })
    end,
    config = function(_, opts)
        require('snacks').setup(opts)

        vim.api.nvim_create_autocmd('User', {
            pattern = 'OilActionsPost',
            callback = function(event)
                if event.data.actions[1].type == 'move' then
                    Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
                end
            end,
        })

        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesActionRename',
            callback = function(event)
                Snacks.rename.on_rename_file(event.data.from, event.data.to)
            end,
        })

        -- Fix for a while
        local M = require('snacks.picker.core.main')
        M.new = function(opts)
            opts = vim.tbl_extend('force', {
                float = false,
                file = true,
                current = false,
            }, opts or {})
            local self = setmetatable({}, M)
            self.opts = opts
            self.win = vim.api.nvim_get_current_win()
            return self
        end
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        {
            'folke/todo-comments.nvim',
            optional = true,
            keys = {
                {
                    '<leader>st',
                    function()
                        Snacks.picker.todo_comments()
                    end,
                    desc = '[Snacks.Picker] Todo',
                },
                {
                    '<leader>sT',
                    function()
                        Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } })
                    end,
                    desc = '[Snacks.Picker] Todo/Fix/Fixme',
                },
            },
        },
    },
}

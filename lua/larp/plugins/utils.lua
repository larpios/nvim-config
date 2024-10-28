return {
    {

        'lambdalisue/vim-suda',
        config = function()
            larp.fn.map('n', '<leader><leader>Sw', ':SudaWrite<CR>', { noremap = true })
            larp.fn.map('n', '<leader><leader>Sr', ':SudaRead<CR>', { noremap = true })
        end,
    },
    {
        'ziontee113/color-picker.nvim',
        event = 'BufEnter',
        keys = {
            { '<leader>uc' },
            { '<c-e>uc', mode = 'i' },
        },
        config = function()
            local get_opts = function(tbl)
                local new_opts = { noremap = true, silent = true }
                for k, v in pairs(tbl) do
                    new_opts[k] = v
                end
                return new_opts
            end
            larp.fn.map('n', '<leader>uc', '<cmd>PickColor<cr>', get_opts({ desc = 'Open Color Picker' }))
            larp.fn.map('i', '<c-e>uc', '<cmd>PickColor<cr>', get_opts({ desc = 'Open Color Picker' }))
        end,
    },
    {
        -- Disabled because using it with noice.nvim is annoying,
        -- and the project is not maintained anymore
        'gelguy/wilder.nvim',
        event = 'BufEnter',
        config = function()
            local wilder = require('wilder')

            -- local gradient = {
            --     '#f4468f',
            --     '#fd4a85',
            --     '#ff507a',
            --     '#ff566f',
            --     '#ff5e63',
            --     '#ff6658',
            --     '#ff704e',
            --     '#ff7a45',
            --     '#ff843d',
            --     '#ff9036',
            --     '#f89b31',
            --     '#efa72f',
            --     '#e6b32e',
            --     '#dcbe30',
            --     '#d2c934',
            --     '#c8d43a',
            --     '#bfde43',
            --     '#b6e84e',
            --     '#aff05b',
            -- }
            --
            -- for i, fg in ipairs(gradient) do
            --     gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = fg } })
            -- end

            wilder.set_option(
                'renderer',
                wilder.renderer_mux({
                    [':'] = wilder.popupmenu_renderer(wilder.popupmenu_border_theme({
                        highlights = {
                            border = 'Normal',
                            accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
                            -- gradient = gradient,
                        },
                        border = 'rounded',
                        highlighter = wilder.highlighter_with_gradient({
                            wilder.basic_highlighter(),
                        }),
                    })),
                    ['/'] = wilder.wildmenu_renderer({
                        highlights = {
                            accent = wilder.make_hl('WilderAccent', 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = '#f4468f' } }),
                        },
                        highlighter = wilder.basic_highlighter(),
                    }),
                })
            )
            wilder.setup({
                modes = { '/**', ':', '/', '?', '!' },
                history = false,
                quick_ref_commands = { 'History', 'History:' },
                pipeline = {
                    { 'builtin', 'cmd_history' },
                    { 'builtin', 'path' },
                    { 'builtin', 'grep' },
                    { 'builtin', 'help' },
                    { 'builtin', 'file' },
                },
            })
        end,
    },
    {
        'nvim-pack/nvim-spectre',
        config = function()
            vim.keymap.set('n', '<leader>RR', '<cmd>lua require("spectre").toggle()<CR>', {
                desc = 'Toggle Spectre',
            })
            vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
                desc = 'Search current word',
            })
            vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
                desc = 'Search current word',
            })
            vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
                desc = 'Search on current file',
            })
        end,
    },

    -- Snapshop code
    {
        'mistricky/codesnap.nvim',
        build = 'make build_generator',
        keys = {
            { '<leader>xcc', '<cmd>CodeSnap<cr>', mode = 'x', desc = 'Save selected code snapshot into clipboard' },
            { '<leader>xcs', '<cmd>CodeSnapSave<cr>', mode = 'x', desc = 'Save selected code snapshot in ~/Pictures' },
        },
        opts = {
            save_path = '~/Pictures',
            has_breadcrumbs = true,
            bg_theme = 'bamboo',
        },
    },

    {
        'mrjones2014/legendary.nvim',
        -- since legendary.nvim handles all your keymaps/commands,
        -- its recommended to load legendary.nvim before other plugins
        priority = 10000,
        lazy = false,
        -- sqlite is only needed if you want to use frecency sorting
        dependencies = { 'kkharji/sqlite.lua' },
        keys = {
            { '<leader>fK', '<cmd>Legendary<cr>', desc = 'Open Legendary' },
        },
        config = function()
            require('legendary').setup({
                extensions = {
                    lazy_nvim = true,
                    smart_splits = {},
                },
            })
        end,
    },
    {
        'ziontee113/color-picker.nvim',
        config = function()
            local opts = { noremap = true, silent = true }

            larp.fn.map('n', '<leader><leader>pc', '<cmd>PickColor<cr>', opts)
            require('color-picker').setup({ -- for changing icons & mappings
                -- ["icons"] = { "ﱢ", "" },
                -- ["icons"] = { "ﮊ", "" },
                -- ["icons"] = { "", "ﰕ" },
                -- ["icons"] = { "", "" },
                -- ["icons"] = { "", "" },
                ['icons'] = { 'ﱢ', '' },
                ['border'] = 'rounded', -- none | single | double | rounded | solid | shadow
                ['keymap'] = { -- mapping example:
                    ['U'] = '<Plug>ColorPickerSlider5Decrease',
                    ['O'] = '<Plug>ColorPickerSlider5Increase',
                },
                ['background_highlight_group'] = 'Normal', -- default
                ['border_highlight_group'] = 'FloatBorder', -- default
                ['text_highlight_group'] = 'Normal', --default
            })

            vim.cmd([[hi FloatBorder guibg=NONE]]) -- if you don't want weird border background colors around the popup.
        end,
    },
    {
        'otavioschwanck/arrow.nvim',
        enabled = false,
        opts = {
            show_icons = true,
            leader_key = ';', -- Recommended to be a single key
            buffer_leader_key = 'm', -- Per Buffer Mappings
        },
        config = function()
            larp.fn.map('n', 'H', require('arrow.persist').previous)
            larp.fn.map('n', 'L', require('arrow.persist').next)
            larp.fn.map('n', '<C-s>', require('arrow.persist').toggle)
        end,
    },
    {
        -- Preview the definition of the word under the cursor
        'rmagatti/goto-preview',
        event = 'BufEnter',
        config = function()
            require('goto-preview').setup({
                default_mappings = true,
            })
        end,
    },
    {
        -- Provides REPLs for various languages
        'Vigemus/iron.nvim',
        enabled = false,
        config = function()
            local iron = require('iron.core')

            iron.setup({
                config = {
                    -- Whether a repl should be discarded or not
                    scratch_repl = true,
                    -- Your repl definitions come here
                    repl_definition = {
                        sh = {
                            -- Can be a table or a function that
                            -- returns a table (see below)
                            command = { 'zsh' },
                        },
                        python = {
                            command = { 'python3' }, -- or { "ipython", "--no-autoindent" }
                            format = require('iron.fts.common').bracketed_paste_python,
                        },
                    },
                    -- How the repl window will be displayed
                    -- See below for more information
                    repl_open_cmd = require('iron.view').bottom(40),
                },
                -- Iron doesn't set keymaps by default anymore.
                -- You can set them here or manually add keymaps to the functions in iron.core
                keymaps = {
                    send_motion = '<space>Sc',
                    visual_send = '<space>Sc',
                    send_file = '<space>Sf',
                    send_line = '<space>Sl',
                    send_paragraph = '<space>Sp',
                    send_until_cursor = '<space>Su',
                    send_mark = '<space>Sm',
                    mark_motion = '<space>mc',
                    mark_visual = '<space>mc',
                    remove_mark = '<space>md',
                    cr = '<space>S<cr>',
                    interrupt = '<space>S<space>',
                    exit = '<space>Sq',
                    clear = '<space>cl',
                },
                -- If the highlight is on, you can change how it looks
                -- For the available options, check nvim_set_hl
                highlight = {
                    italic = true,
                },
                ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
            })

            -- iron also has a list of commands, see :h iron-commands for all available commands
            vim.keymap.set('n', '<space>rs', '<cmd>IronRepl<cr>')
            vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
            vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
            vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
        end,
    },
    {
        'epwalsh/pomo.nvim',
        version = '*', -- Recommended, use latest release instead of latest commit
        lazy = true,
        cmd = { 'TimerStart', 'TimerRepeat', 'TimerSession' },
        dependencies = {
            -- Optional, but highly recommended if you want to use the "Default" timer
            'rcarriga/nvim-notify',
        },
        opts = {
            -- See below for full list of options 👇
            sessions = {
                pomodoro = {
                    { name = 'Work', duration = '25m' },
                    { name = 'Short Break', duration = '5m' },
                    { name = 'Work', duration = '25m' },
                    { name = 'Short Break', duration = '5m' },
                    { name = 'Work', duration = '25m' },
                    { name = 'Long Break', duration = '15m' },
                },
            },
        },
    },
    {
        'stevearc/resession.nvim',
        opts = {},
        config = function()
            local resession = require('resession')
            resession.setup({
                autosave = {
                    enabled = true,
                    interval = 60,
                    notify = true,
                },
            })
            larp.fn.map('n', '<leader>Ss', resession.save)
            larp.fn.map('n', '<leader>Sl', resession.load)
            larp.fn.map('n', '<leader>Sd', resession.delete)
            vim.api.nvim_create_autocmd('VimLeavePre', {
                callback = function()
                    -- Always save a special session named "last"
                    resession.save('last')
                end,
            })
        end,
    },
    {
        -- Better terminal support with persistent history
        'akinsho/toggleterm.nvim',
        version = '*',
        opts = {},
        config = function()
            require('toggleterm').setup({
                open_mapping = [[<c-\>]],
            })
        end,
    },
    {
        'stevearc/quicker.nvim',
        event = 'FileType qf',
        ---@module "quicker"
        ---@type quicker.SetupOptions
        opts = {
            keys = {
                {
                    '>',
                    function()
                        quicker.expand({ before = 2, after = 2, add_to_existing = true })
                    end,
                    desc = 'Expand quickfix context',
                },
                {
                    '<',
                    function()
                        quicker.collapse()
                    end,
                    desc = 'Collapse quickfix context',
                },
            },
            opts = {
                buflisted = true,
                number = true,
                relativenumber = true,
                wrap = true,
            },
        },
        config = function(_, opts)
            local quicker = require('quicker')

            quicker.setup(opts)
            larp.fn.map('n', '<leader>tq', function()
                quicker.toggle()
            end, { desc = 'Toggle quickfix' })

            larp.fn.map('n', '<leader>tl', function()
                quicker.toggle({ loclist = true })
            end, { desc = 'Toggle loclist' })
        end,
    },
    -- {
    --     'TobinPalmer/pastify.nvim',
    --     cmd = { 'Pastify', 'PastifyAfter' },
    --     opts = {},
    -- },
    {
        'kjwsl/paste.nvim',
        enabled = false,
        opts = {},
    },
    {
        'HakonHarnes/img-clip.nvim',
        event = 'VeryLazy',
        opts = {
            -- add options here
            -- or leave it empty to use the default settings
        },
        keys = {
            -- suggested keymap
            { '<leader>P', '<cmd>PasteImage<cr>', desc = 'Paste image from system clipboard' },
        },
    },
    {
        'NMAC427/guess-indent.nvim',
        opts = {},
    },
    {
        'rmagatti/auto-session',
        lazy = false,

        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
            -- log_level = 'debug',
        },
    },
}

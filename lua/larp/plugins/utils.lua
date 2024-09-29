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
        'LintaoAmons/bookmarks.nvim',
        -- tag = "v0.5.4", -- optional, pin the plugin at specific version for stability
        dependencies = {
            { 'nvim-telescope/telescope.nvim' },
            { 'stevearc/dressing.nvim' }, -- optional: to have the same UI shown in the GIF
        },

        keys = {
            { 'mm', mode = { 'n', 'v' }, desc = 'Mark current line into active BookmarkList.' },
            { 'mo', mode = { 'n', 'v' }, desc = 'Go to bookmark at current active BookmarkList' },
            { 'ma', mode = { 'n', 'v' }, desc = 'Find and trigger a bookmark command.' },
            { 'mg', mode = { 'n', 'v' }, desc = 'Go to latest visited/created Bookmark' },
        },
        config = function()
            larp.fn.map({ 'n', 'v' }, 'mm', '<cmd>BookmarksMark<cr>', { desc = 'Mark current line into active BookmarkList.' })
            larp.fn.map({ 'n', 'v' }, 'mo', '<cmd>BookmarksGoto<cr>', { desc = 'Go to bookmark at current active BookmarkList' })
            larp.fn.map({ 'n', 'v' }, 'ma', '<cmd>BookmarksCommands<cr>', { desc = 'Find and trigger a bookmark command.' })
            larp.fn.map({ 'n', 'v' }, 'mg', '<cmd>BookmarksGotoRecent<cr>', { desc = 'Go to latest visited/created Bookmark' })
        end,
    },
    {
        'ibhagwan/fzf-lua',
        -- optional for icon support
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            { 'junegunn/fzf', build = './install --bin' },
        },
        config = function()
            local fzf = require('fzf-lua')
            -- calling `setup` is optional for customization
            fzf.setup({
                'fzf-native',
                hls = {
                    Rg = {
                        cmd = 'rg --vimgrep --no-heading --smart-case',
                        previewer = 'bat',
                    },
                },
                fzf_colors = true,
            })
            larp.fn.map({ 'i' }, '<C-x><C-f>', function()
                fzf.complete_file({
                    cmd = 'rg --files',
                    winopts = { preview = { hidden = 'nohidden' } },
                })
            end, { silent = true, desc = 'Fuzzy complete file' })
        end,
    },
    {
        'mfussenegger/nvim-dap',
    },
    {
        'nvim-telescope/telescope.nvim',
        tag = '0.1.6',
        dependencies = {
            'nvim-lua/plenary.nvim',
            { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
            'BurntSushi/ripgrep',
            'sharkdp/fd',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            local telescope = require('telescope')
            local actions = require('telescope.actions')
            telescope.setup({
                defaults = {
                    path_display = { 'truncate ' }, -- Example configuration
                    mappings = {
                        i = {
                            ['<C-k>'] = actions.move_selection_previous,
                            ['<C-j>'] = actions.move_selection_next,
                            ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                        },
                    },
                },
            })
        end,
    },
    {
        -- 1. Highlights TODO, FIXME, etc. in your code
        -- 2. Provides a list of all the highlights in your project
        'folke/todo-comments.nvim',
        event = 'BufRead',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {

            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        config = function()
            require('todo-comments').setup({})
            larp.fn.map('n', ']t', function()
                require('todo-comments').jump_next()
            end, { desc = 'Next todo comment' })
            larp.fn.map('n', '[t', function()
                require('todo-comments').jump_prev()
            end, { desc = 'Previous todo comment' })
            -- You can also specify a list of valid jump keywords
            larp.fn.map('n', ']t', function()
                require('todo-comments').jump_next({ keywords = { 'ERROR', 'WARNING' } })
            end, { desc = 'Next error/warning todo comment' })
        end,
    },
    {
        'gelguy/wilder.nvim',
        config = function()
            local wilder = require('wilder').setup({
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
        -- better yank history
        'ptdewey/yankbank-nvim',
        dependencies = 'kkharji/sqlite.lua',
        config = function()
            require('yankbank').setup({
                persist_type = 'sqlite',
            })
        end,
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
                extensions = { lazy_nvim = true, smart_splits = true },
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
        'rmagatti/auto-session',
        lazy = false,

        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
            -- log_level = 'debug',
        },
        config = function()
            require('auto-session').setup()
            -- Will use Telescope if installed or a vim.ui.select picker otherwise
            larp.fn.map('n', '<leader><leader>sr', '<cmd>SessionSearch<CR>', { desc = 'Session search' })
            larp.fn.map('n', '<leader><leader>ss', '<cmd>SessionSave<CR>', { desc = 'Save session' })
            larp.fn.map('n', '<leader><leader>sa', '<cmd>SessionToggleAutoSave<CR>', { desc = 'Toggle autosave' })
        end,
    },
    {
        -- Preview the definition of the word under the cursor
        'rmagatti/goto-preview',
        enabled = false,
        event = 'BufEnter',
        config = true, -- necessary as per https://github.com/rmagatti/goto-preview/issues/88
    },
    {
        'Vigemus/iron.nvim',
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
}

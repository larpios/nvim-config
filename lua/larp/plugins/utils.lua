return {
    {

        'lambdalisue/vim-suda',
        config = function()
            larp.fn.map('n', '<leader><leader>Sw', ':SudaWrite<CR>', { noremap = true })
            larp.fn.map('n', '<leader><leader>Sr', ':SudaRead<CR>', { noremap = true })
        end,
    },
    {
        -- Disabled because using it with noice.nvim is annoying,
        -- and the project is not maintained anymore
        'gelguy/wilder.nvim',
        event = 'BufEnter',
        config = function()
            require('custom.wilder')
        end,
    },
    {
        'nvim-pack/nvim-spectre',
        keys = {
            { '<leader>St', '<cmd>Spectre<cr>', mode = 'n', desc = 'Toggle Spectre' },
            { '<leader>Sw', '<cmd>Spectre<cr>', mode = 'v', desc = 'Search current word' },
            { '<leader>Sp', '<cmd>Spectre<cr>', mode = 'n', desc = 'Search on current file' },
        },
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
        opts = {
            extensions = {
                lazy_nvim = true,
                smart_splits = {},
            },
        },
    },
    {
        'otavioschwanck/arrow.nvim',
        enabled = false,
        opts = {
            show_icons = true,
            leader_key = ';', -- Recommended to be a single key
            buffer_leader_key = 'm', -- Per Buffer Mappings
        },
        keys = {
            { 'H', '<cmd>lua require("arrow.persist").previous()<cr>', desc = 'Previous Buffer' },
            { 'L', '<cmd>lua require("arrow.persist").next()<cr>', desc = 'Next Buffer' },
            { '<C-s>', '<cmd>lua require("arrow.persist").toggle()<cr>', desc = 'Toggle Buffer' },
        },
    },
    {
        -- Preview the definition of the word under the cursor
        'rmagatti/goto-preview',
        event = 'BufEnter',
        opts = {
            default_mappings = true,
        },
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
        'stevearc/resession.nvim',
        config = function()
            require('custom.resessions')
        end,
    },
    {
        -- Better terminal support with persistent history
        'akinsho/toggleterm.nvim',
        version = '*',
        opts = {
            open_mapping = [[<c-\>]],
        },
    },
    {
        'stevearc/quicker.nvim',
        ft = 'qf',
        config = function()
            require('custom.quicker')
        end,
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
        'kevinhwang91/nvim-bqf',
        ft = 'qf',
        dependencies = {
            {
                'junegunn/fzf',
                run = function()
                    vim.fn['fzf#install']()
                end,
            },
            { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
        },
    },
    {
        'meznaric/key-analyzer.nvim',
        opts = {},
        'chomosuke/term-edit.nvim',
        event = 'TermOpen',
        version = '1.*',
        opts = {
            prompt_end = '%$ ',
        },
    },
    {
        'folke/snacks.nvim',
        priority = 1000,
        lazy = false,
        config = function()
            require('custom.snacks')
        end,
    },
}

-- optional, highly recommended

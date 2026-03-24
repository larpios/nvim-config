return {
    {
        'nvim-lualine/lualine.nvim',
        event = 'BufWinEnter',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'stevearc/overseer.nvim',
        },
        config = function()
            local overseer = require('overseer')
            local recorder = require('recorder') -- nvim-recorder

            require('lualine').setup({
                options = {
                    theme = 'auto',
                },
                sections = {
                    lualine_a = { 'mode' },
                    lualine_b = { 'branch', 'diff', 'diagnostics' },
                    lualine_c = {
                        'filename',
                        {
                            function()
                                return vim.bo.modified and '' or ''
                            end,
                        },
                        {
                            function()
                                return vim.bo.readonly and '' or ''
                            end,
                        },
                        {
                            function()
                                return vim.bo.buftype == 'quickfix' and '' or ''
                            end,
                        },
                    },
                    lualine_x = {
                        {
                            'overseer',
                            label = '',     -- Prefix for task counts
                            colored = true, -- Color the task icons and counts
                            symbols = {
                                [overseer.STATUS.FAILURE] = 'F:',
                                [overseer.STATUS.CANCELED] = 'C:',
                                [overseer.STATUS.SUCCESS] = 'S:',
                                [overseer.STATUS.RUNNING] = 'R:',
                            },
                            unique = false,     -- Unique-ify non-running task count by name
                            name = nil,         -- List of task names to search for
                            name_not = false,   -- When true, invert the name search
                            status = nil,       -- List of task statuses to display
                            status_not = false, -- When true, invert the status search
                        },
                        {
                            --- Lsp server name
                            function()
                                local msg = 'No Active Lsp'
                                local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                                local clients = vim.lsp.get_clients()
                                if next(clients) == nil then
                                    return msg
                                end
                                for _, client in ipairs(clients) do
                                    local filetypes = client.config.filetypes
                                    if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                        return client.name
                                    end
                                end
                                return msg
                            end,
                        },
                        'encoding',
                        'fileformat',
                        'filetype',
                    },
                    lualine_y = { 'progress', recorder.displaySlots },
                    lualine_z = { 'location', recorder.recordingStatus },
                },
            })
        end,
    },
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        opts = {
            -- add any options here
        },
        dependencies = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            'MunifTanjim/nui.nvim',
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            'nvim-treesitter/nvim-treesitter',
        },
        keys = {
            { '<leader>nd', '<cmd>NoiceDismiss<cr>', desc = 'Dismiss Notification', silent = true },
        },
        config = function()
            require('noice').setup({
                lsp = {
                    signature = { enabled = false },
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
                        ['vim.lsp.util.stylize_markdown'] = true,
                        ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = false,        -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = true,            -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true,        -- add a border to hover docs and signature help
                },
            })
            vim.api.nvim_create_autocmd('RecordingEnter', {
                callback = function()
                    local msg = string.format('Register:  %s', vim.fn.reg_recording())
                    _MACRO_RECORDING_STATUS = true
                    vim.notify(msg, vim.log.levels.INFO, {
                        title = 'Macro Recording',
                        keep = function()
                            return _MACRO_RECORDING_STATUS
                        end,
                    })
                end,
                group = vim.api.nvim_create_augroup('NoiceMacroNotfication', { clear = true }),
            })

            vim.api.nvim_create_autocmd('RecordingLeave', {
                callback = function()
                    _MACRO_RECORDING_STATUS = false
                    vim.notify('Success!', vim.log.levels.INFO, {
                        title = 'Macro Recording End',
                        timeout = 2000,
                    })
                end,
                group = vim.api.nvim_create_augroup('NoiceMacroNotficationDismiss', { clear = true }),
            })
        end,
    },
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        -- Loading screen on the bottom right
        'j-hui/fidget.nvim',
        event = 'VeryLazy',
        opts = {
            -- options
        },
    },
    {
        -- Peek buffer while typing :<linenumber>
        'nacro90/numb.nvim',
        config = true,
    },
    {
        'petertriho/nvim-scrollbar',
        event = 'BufReadPost',
    },
    {
        'folke/trouble.nvim',
        branch = 'main', -- IMPORTANT!
        keys = {
            {
                '<leader>xx',
                '<cmd>Trouble diagnostics toggle<cr>',
                desc = 'Diagnostics (Trouble)',
            },
            {
                '<leader>xX',
                '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
                desc = 'Buffer Diagnostics (Trouble)',
            },
            {
                '<leader>cs',
                '<cmd>Trouble symbols toggle focus=false<cr>',
                desc = 'Symbols (Trouble)',
            },
            {
                '<leader>cl',
                '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
                desc = 'LSP Definitions / references / ... (Trouble)',
            },
            {
                '<leader>xL',
                '<cmd>Trouble loclist toggle<cr>',
                desc = 'Location List (Trouble)',
            },
            {
                '<leader>xQ',
                '<cmd>Trouble qflist toggle<cr>',
                desc = 'Quickfix List (Trouble)',
            },
        },
        opts = {}, -- for default options, refer to the configuration section for custom setup.
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        keys = {
            {
                '<leader>?',
                function()
                    require('which-key').show({ global = false })
                end,
                desc = 'Buffer Local Keymaps (which-key)',
            },
        },
        config = function()
            local wk = require('which-key')

            local opts = {
                preset = 'modern',
            }

            wk.setup(opts)
        end,
    },
    {
        -- Colorful window separator
        'nvim-zh/colorful-winsep.nvim',
        config = true,
        event = { 'WinLeave' },
    },
    {
        -- Changes the color of the line number depending on the current mode.
        'mawkler/modicator.nvim',
        event = 'VeryLazy',
        init = function()
            -- These are required for Modicator to work
            vim.o.cursorline = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        opts = {},
    },
    {
        'nvzone/showkeys',
        cmd = 'ShowkeysToggle',
        opts = {
            maxkeys = 5,
            winopts = {
                focusable = true,
            },
            show_count = true,
            position = 'top-right',
        },
    },
    {
        -- Neovide-like cursor
        'sphamba/smear-cursor.nvim',
        enabled = false,
        event = 'BufWinEnter',
        config = function()
            require('smear-cursor').setup({
                cursor_color = '#efd4fc',
                stiffness = 0.8,
                trailing_stiffness = 0.2,
                trailing_exponent = 0.8,
                hide_target_hack = true,
                gamma = 0.8,
            })
        end,
    },
    {
        -- Tabs
        'akinsho/bufferline.nvim',
        event = 'BufWinEnter',
        version = '*',
        dependencies = 'nvim-tree/nvim-web-devicons',
        opts = {},
        keys = {
            { 'L',          '<cmd>BufferLineCycleNext<cr>', mode = 'n', desc = 'Next Buffer' },
            { 'H',          '<cmd>BufferLineCyclePrev<cr>', mode = 'n', desc = 'Previous Buffer' },
            { '<leader>>',  '<cmd>BufferLineMoveNext<cr>',  mode = 'n', desc = 'Move Buffer to the Right' },
            { '<leader><',  '<cmd>BufferLineMovePrev<cr>',  mode = 'n', desc = 'Move Buffer to the Left' },
            { '<leader>bc', '<cmd>BufferLinePickClose<cr>', mode = 'n', desc = 'Close buffer' },
            { '<leader>bp', '<cmd>BufferLinePick<cr>',      mode = 'n', desc = 'Pick Buffer' },
            { '<leader>br', '<cmd>BufferLineTabRename<cr>', mode = 'n', desc = 'Rename Tab' },
        },
    },
    {
        'jake-stewart/auto-cmdheight.nvim',
        lazy = false,
        opts = {
            -- max cmdheight before displaying hit enter prompt.
            max_lines = 5,

            -- number of seconds until the cmdheight can restore.
            duration = 2,

            -- whether key press is required to restore cmdheight.
            remove_on_key = true,

            -- always clear the cmdline after duration and key press.
            -- by default it will only happen when cmdheight changed.
            clear_always = false,
        },
    },
    {
        'mcauley-penney/visual-whitespace.nvim',
        config = true,
        event = 'ModeChanged *:[vV\22]', -- optionally, lazy load on entering visual mode
        opts = {},
    },
    {
        'Bekaboo/dropbar.nvim',
        event = 'BufRead',
        dependencies = {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        },
        keys = {
            { '<leader>;',  function() require('dropbar.api').pick() end,                 desc = '[Dropbar] Pick symbols' },
            { '<leader>[;', function() require('dropbar.api').goto_context_start() end,   desc = '[Dropbar] Go to start of current context' },
            { '<leader>];', function() require('dropbar.api').select_next_context() end,  desc = '[Dropbar] Select next context' },
        },
    }
}

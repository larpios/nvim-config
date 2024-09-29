return {
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
            'rcarriga/nvim-notify',
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
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = false, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = true, -- add a border to hover docs and signature help
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
            larp.fn.map('n', '<leader>dn', '<cmd>NoiceDismiss<cr>', { desc = 'Dismiss Notification' })
        end,
    },
    {
        'nvimdev/dashboard-nvim',
        event = 'VimEnter',
        opts = {
            hide = {
                tabline = true,
            },
        },
        config = function()
            require('dashboard').setup({
                -- config
            })
        end,
        dependencies = { { 'nvim-tree/nvim-web-devicons' } },
    },
    {
        'stevearc/dressing.nvim',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'j-hui/fidget.nvim',
        opts = {
            -- options
        },
    },
    {
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
            '3rd/image.nvim', -- Optional image support in preview window: See `# Preview Mode` for more information
        },
    },
    {
        '3rd/image.nvim',
        enabled = false,
        opts = {
            backend = 'kitty',
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
                },
                neorg = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = false,
                    filetypes = { 'norg' },
                },
                html = {
                    enabled = false,
                },
                css = {
                    enabled = false,
                },
            },
            max_width = nil,
            max_height = nil,
            max_width_window_percentage = nil,
            max_height_window_percentage = 50,
            window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
            window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
            editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
            tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
            hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp', '*.avif' }, -- render image files as images when opened
        },
    },

    {
        'nacro90/numb.nvim',
        config = true,
    },
    {
        'kevinhwang91/nvim-bqf',
    },
    {
        'rcarriga/nvim-notify',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('notify').setup({
                render = 'compact',
                stages = 'slide',
                timeout = 5000,
                background_colour = '#000000',
                icons = {
                    ERROR = '',
                    WARN = '',
                    INFO = '',
                    DEBUG = '',
                    TRACE = '✎',
                },
            })
            larp.fn.map('n', '<leader>fn', '<cmd>Telescope notify<cr>', { desc = 'Find Notify History' })
        end,
    },
    { 'petertriho/nvim-scrollbar' },
    {
        'stevearc/oil.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
        },
        opts = {
            delete_to_trash = true,
            use_default_keymaps = false,
            keymaps = {
                ['g?'] = 'actions.show_help',
                ['<CR>'] = 'actions.select',
                ['<C-5>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
                ["<C-'>"] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
                ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
                ['<C-p>'] = 'actions.preview',
                ['<C-c>'] = 'actions.close',
                ['<F5>'] = 'actions.refresh',
                ['-'] = 'actions.parent',
                ['_'] = 'actions.open_cwd',
                ['`'] = 'actions.cd',
                ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory' },
                ['gs'] = 'actions.change_sort',
                ['gx'] = 'actions.open_external',
                ['g.'] = 'actions.toggle_hidden',
                ['g\\'] = 'actions.toggle_trash',
            },
            watch_for_changes = true,
            view_options = {
                show_hidden = true,
                sort = {
                    { 'type', 'desc' },
                    { 'name', 'asc' },
                },
            },
            sort_by = function(a, b)
                if a.type == 'directory' and b.type ~= 'directory' then
                    return true
                elseif a.type ~= 'directory' and b.type == 'directory' then
                    return false
                else
                    local function get_extension(file)
                        return file.name:match('^.+(%..+)$') or ''
                    end

                    local ext_a = get_extension(a.name):lower()
                    local ext_b = get_extension(b.name):lower()

                    if ext_a == ext_b then
                        return a.name:lower() < b.name:lower()
                    else
                        return ext_a < ext_b
                    end
                end
            end,

            columns = {
                'icon',
                'mtime',
                'size',
                'permissions',
            },
            win_options = {
                wrap = true,
                winbar = "%{v:lua.require('oil').get_current_dir()}",
            },
        },
    },
    {
        'stevearc/overseer.nvim',
        opts = {},
        config = function()
            require('overseer').setup()
        end,
    },
    {
        'xiyaowong/transparent.nvim',
        config = true,
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
        'folke/twilight.nvim',
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        'RRethy/vim-illuminate',
    },
    {
        'folke/which-key.nvim',
        event = 'VeryLazy',
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    -- Lua
    {
        'folke/zen-mode.nvim',
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        keys = {
            { '<leader>tz', '<cmd>ZenMode<cr>', desc = 'Toggle Zen Mode' },
        },
    },
    {
        -- Scrollbar
        'lewis6991/satellite.nvim',
        event = 'BufRead',
    },
    {
        'simonmclean/triptych.nvim',
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim', -- required
            'nvim-tree/nvim-web-devicons', -- optional
        },
        config = function()
            require('triptych').setup()
            larp.fn.map('n', '<leader><leader>t', ':Triptych<CR>', { silent = true })
        end,
    },
    {
        'nvim-zh/colorful-winsep.nvim',
        config = true,
        event = { 'WinLeave' },
    },
    {
        'mawkler/modicator.nvim',
        init = function()
            -- These are required for Modicator to work
            vim.o.cursorline = true
            vim.o.number = true
            vim.o.termguicolors = true
        end,
        opts = {
            -- Warn if any required option above is missing. May emit false positives
            -- if some other plugin modifies them, which in that case you can just
            -- ignore. Feel free to remove this line after you've gotten Modicator to
            -- work properly.
            show_warnings = true,
        },
    },
}

return {
    {
        'nvim-lualine/lualine.nvim',
        event = 'BufWinEnter',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            'stevearc/overseer.nvim',
        },
        config = function()
            require('custom.lualine')
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
            'rcarriga/nvim-notify',
            'nvim-treesitter/nvim-treesitter',
        },
        config = function()
            require('custom.noice')
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
        'nvim-neo-tree/neo-tree.nvim',
        branch = 'v3.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
            'MunifTanjim/nui.nvim',
        },
    },
    {
        -- Peek buffer while typing :<linenumber>
        'nacro90/numb.nvim',
        config = true,
    },
    {
        'rcarriga/nvim-notify',
        lazy = true,
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            require('custom.nvim-notify')
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
                ['-'] = 'actions.parent',
                -- If you want to automatically change the directory when selecting a file
                -- ['<CR>'] = function()
                --     require('oil').select(nil, function(err)
                --         if not err then
                --             local curdir = require('oil').get_current_dir()
                --             if curdir then
                --                 vim.cmd.lcd(curdir)
                --             end
                --         end
                --     end)
                -- end,
                -- ['-'] = function()
                --     require('oil.actions').parent.callback()
                --     vim.cmd.lcd(require('oil').get_current_dir())
                -- end,
                ['<C-5>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
                ["<C-'>"] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
                ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
                ['<C-p>'] = 'actions.preview',
                ['<C-c>'] = 'actions.close',
                ['<F5>'] = 'actions.refresh',
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
            -- sort_by = function(a, b)
            --     if a.type == 'directory' and b.type ~= 'directory' then
            --         return true
            --     elseif a.type ~= 'directory' and b.type == 'directory' then
            --         return false
            --     else
            --         local function get_extension(file)
            --             return file.name:match('^.+(%..+)$') or ''
            --         end
            --
            --         local ext_a = get_extension(a.name):lower()
            --         local ext_b = get_extension(b.name):lower()
            --
            --         if ext_a == ext_b then
            --             return a.name:lower() < b.name:lower()
            --         else
            --             return ext_a < ext_b
            --         end
            --     end
            -- end,
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
        keys = {
            { '-', '<CMD>Oil<CR>', mode = 'n', desc = 'Open parent directory' },
        },
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
        event = 'BufRead',
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
        keys = {
            { '<leader><leader>t', '<cmd>Triptych<cr>', mode = 'n', desc = 'Toggle Triptych' },
        },
        opts = {},
    },
    {
        'nvim-zh/colorful-winsep.nvim',
        config = true,
        event = { 'WinLeave' },
    },
    {
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
        -- Adds nice icons and bars to the signcolumn
        'OXY2DEV/bars-N-lines.nvim',
        -- No point in lazy loading this
        lazy = false,
        enabled = false,
        config = function()
            require('bars').setup({
                statuscolumn = false,
                -- statusline = true,
                -- tabline = true,
            })
        end,
    },
    {
        'folke/twilight.nvim',
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
}

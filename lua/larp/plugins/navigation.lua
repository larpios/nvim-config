return {
    {
        'stevearc/oil.nvim',
        lazy = false,
        tag = 'stable',
        dependencies = {
            'echasnovski/mini.icons',
        },
        opts = {
            default_file_explorer = true,
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
                ['<C-v>'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
                ["<C-g>"] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
                -- ['<C-t>'] = { 'actions.select', opts = { tab = true }, desc = 'Open the entry in new tab' },
                ['<C-p>'] = 'actions.preview',
                ['<C-c>'] = 'actions.close',
                ['<F5>'] = 'actions.refresh',
                ['_'] = 'actions.open_cwd',
                ['`'] = 'actions.cd',
                -- ['~'] = { 'actions.cd', opts = { scope = 'tab' }, desc = ':tcd to the current oil directory' },
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
            {
                '-',
                function()
                    if vim.bo.buftype == '' then
                        require('oil').open()
                    end
                end,
                mode = 'n',
                desc = 'Open parent directory',
            },
        },
    },
    {
        'folke/flash.nvim',
        event = 'VeryLazy',
        ---@type Flash.Config
        opts = {
            modes = {
                char = {
                    jump_labels = true,
                },
            },
        },
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
    {
        'mikavilpas/yazi.nvim',
        event = 'VeryLazy',
        dependencies = {
            { 'nvim-lua/plenary.nvim', lazy = true },
        },
        keys = {
            -- 👇 in this section, choose your own keymappings!
            {
                '<leader>ty',
                mode = { 'n', 'v' },
                '<cmd>Yazi<cr>',
                desc = 'Open yazi at the current file',
            },
            -- {
            --     -- Open in the current working directory
            --     '<leader>cw',
            --     '<cmd>Yazi cwd<cr>',
            --     desc = "Open the file manager in nvim's working directory",
            -- },
            -- {
            --     '<c-up>',
            --     '<cmd>Yazi toggle<cr>',
            --     desc = 'Resume the last yazi session',
            -- },
        },
        ---@type YaziConfig | {}
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = '<f1>',
            },
        },
        -- 👇 if you use `open_for_directories=true`, this is recommended
        init = function()
            -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
            -- vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1
        end,
    },
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        ---@type Flash.Config
        opts = {
            modes = {
                char = {
                    jump_labels = true,
                },
            },
        },
        -- stylua: ignore
        keys = {
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    }
}

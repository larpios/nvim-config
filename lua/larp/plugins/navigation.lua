return {
    {
        'stevearc/oil.nvim',
        lazy = false,
        tag = 'stable',
        dependencies = {
            'nvim-mini/mini.icons',
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
                ['<C-g>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
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
        'ibhagwan/fzf-lua',
        dependencies = { 'nvim-mini/mini.icons' },
        opts = {
            winopts = {
                preview = {
                    wrap = true,
                    hidden = false,
                },
            },
        },
        keys = {
            {
                '<leader>fp',
                function()
                    require('fzf-lua').builtin()
                end,
                desc = '[FzfLua] Pick',
            },
            {
                '<leader>ff',
                function()
                    require('fzf-lua').files()
                end,
                desc = '[FzfLua] Files',
            },
            {
                '<leader>fc',
                function()
                    require('fzf-lua').files({ cwd = vim.fn.stdpath('config') })
                end,
                desc = '[FzfLua] Neovim Files',
            },
            {
                '<leader>f.',
                function()
                    require('fzf-lua').resume()
                end,
                desc = '[FzfLua] Resume',
            },
            {
                '<leader>fF',
                function()
                    require('fzf-lua').global()
                end,
                desc = '[FzfLua] Global Search',
            },
            {
                '<leader>fb',
                function()
                    require('fzf-lua').buffers()
                end,
                desc = '[FzfLua] Buffers',
            },
            {
                '<leader>fr',
                function()
                    require('fzf-lua').oldfiles()
                end,
                desc = '[FzfLua] Recent',
            },
            {
                '<leader>fH',
                function()
                    require('fzf-lua').history()
                end,
                desc = '[FzfLua] History',
            },
            {
                '<leader>fb',
                function()
                    require('fzf-lua').blines()
                end,
                desc = '[FzfLua] Current Buffer Lines',
            },
            {
                '<leader>fB',
                function()
                    require('fzf-lua').lines()
                end,
                desc = '[FzfLua] Buffers Lines',
            },
            {
                '<leader>ft',
                function()
                    require('fzf-lua').treesitter()
                end,
                desc = '[FzfLua] Treesitter',
            },
            {
                '<leader>fT',
                function()
                    require('fzf-lua').tabs()
                end,
                desc = '[FzfLua] Tabs',
            },
            {
                '<leader>fv',
                function()
                    require('fzf-lua').vcs_files()
                end,
                desc = '[FzfLua] VCS Files (Git/Jujutsu)',
            },
            {
                '<leader>fh',
                function()
                    require('fzf-lua').helptags()
                end,
                desc = '[FzfLua] Help',
            },
            {
                '<leader>fm',
                function()
                    require('fzf-lua').manpages()
                end,
                desc = '[FzfLua] Man Pages',
            },
            {
                '<leader>fC',
                function()
                    require('fzf-lua').commands()
                end,
                desc = '[FzfLua] Commands',
            },
            {
                '<leader>f:',
                function()
                    require('fzf-lua').command_history()
                end,
                desc = '[FzfLua] Command History',
            },
            {
                '<leader>f"',
                function()
                    require('fzf-lua').registers()
                end,
                desc = '[FzfLua] Registers',
            },
            {
                '<leader>fxc',
                function()
                    require('fzf-lua').changes()
                end,
                desc = '[FzfLua] Changes',
            },
            {
                '<leader>fu',
                function()
                    require('fzf-lua').undotree()
                end,
                desc = '[FzfLua] Undotree',
            },
            {
                '<leader>fk',
                function()
                    require('fzf-lua').keymaps()
                end,
                desc = '[FzfLua] Keymaps',
            },
            {
                '<leader>fj',
                function()
                    require('fzf-lua').jumps()
                end,
                desc = '[FzfLua] Jumps',
            },
            {
                '<leader>fa',
                function()
                    require('fzf-lua').autocmds()
                end,
                desc = '[FzfLua] Autocmds',
            },
            {
                '<leader>fxt',
                function()
                    require('fzf-lua').tmux_buffers()
                end,
                desc = '[FzfLua] Tmux Buffers',
            },
            {
                '<leader>fz',
                function()
                    require('fzf-lua').zoxide()
                end,
                desc = '[FzfLua] Zoxide',
            },

            -- Grep
            {
                '<leader>sg',
                function()
                    require('fzf-lua').live_grep()
                end,
                desc = '[FzfLua] Grep',
            },
            {
                '<leader>sc',
                function()
                    require('fzf-lua').live_grep({ cwd = vim.fn.stdpath('config') })
                end,
                desc = '[FzfLua] Grep Neovim',
            },
            {
                '<leader>sw',
                function()
                    require('fzf-lua').grep_cword()
                end,
                desc = '[FzfLua] Grep Word',
            },
            {
                '<leader>sW',
                function()
                    require('fzf-lua').grep_cWORD()
                end,
                desc = '[FzfLua] Grep WORD',
            },
            {
                '<leader>sw',
                function()
                    require('fzf-lua').grep_visual()
                end,
                mode = { 'x', 'v' },
                desc = '[FzfLua] Grep Selection',
            },
            {
                '<leader>sl',
                function()
                    require('fzf-lua').grep_loclist()
                end,
                desc = '[FzfLua] Grep Loclist',
            },

            -- LSP
            {
                'grr',
                function()
                    require('fzf-lua').lsp_references()
                end,
                desc = '[FzfLua] LSP References',
            },
            {
                'gd',
                function()
                    require('fzf-lua').lsp_definitions()
                end,
                desc = '[FzfLua] LSP Definitions',
            },
            {
                'gD',
                function()
                    require('fzf-lua').lsp_declarations()
                end,
                desc = '[FzfLua] LSP Declarations',
            },
            {
                'grt',
                function()
                    require('fzf-lua').lsp_typedefs()
                end,
                desc = '[FzfLua] LSP Type Definitions',
            },
            {
                'gri',
                function()
                    require('fzf-lua').lsp_implementations()
                end,
                desc = '[FzfLua] LSP Implementations',
            },
            {
                'grci',
                function()
                    require('fzf-lua').lsp_incoming_calls()
                end,
                desc = '[FzfLua] LSP Incoming Calls',
            },
            {
                'grco',
                function()
                    require('fzf-lua').lsp_outcoming_calls()
                end,
                desc = '[FzfLua] LSP Outcoming Calls',
            },
            {
                'gra',
                function()
                    require('fzf-lua').lsp_code_actions()
                end,
                desc = '[FzfLua] LSP Code Actions',
            },
            {
                '<leader>sd',
                function()
                    require('fzf-lua').diagnostics_document()
                end,
                desc = '[FzfLua] Diagnostics Document',
            },
            {
                '<leader>sD',
                function()
                    require('fzf-lua').diagnostics_workspace()
                end,
                desc = '[FzfLua] Diagnostics Workspace',
            },

            -- Jujutsu
            {
                '<leader>jsf',
                function()
                    require('fzf-lua').jj_files()
                end,
                desc = '[FzfLua] Jujutsu Files',
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
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
    {
        'mikavilpas/yazi.nvim',
        version = '*',
        event = 'VeryLazy',
        dependencies = {
            { 'nvim-lua/plenary.nvim', lazy = true },
        },
        keys = {
            {
                '<leader>ty',
                mode = { 'n', 'v' },
                '<cmd>Yazi<cr>',
                desc = '[Yazi] Open yazi at the current file',
            },
            {
                -- Open in the current working directory
                '<leader>tY',
                '<cmd>Yazi cwd<cr>',
                desc = "[Yazi] Open the file manager in nvim's working directory",
            },
        },
        ---@type YaziConfig | {}
        opts = {
            -- enable it if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = '<f1>',
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
            { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
            { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
            { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
            { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
        },
    },
}

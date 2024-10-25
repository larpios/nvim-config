return {
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        lazy = false,
        config = function()
            require('Comment').setup()
        end,
    },
    {
        'ggandor/leap.nvim',
        dependencies = { 'tpope/vim-repeat' },
        config = function()
            local leap = require('leap')
            local user = require('leap.user')

            vim.keymap.set('n', 'ss', '<Plug>(leap)')
            vim.keymap.set('n', 'sw', '<Plug>(leap-from-window)')
            vim.keymap.set({ 'x', 'o' }, 'sf', '<Plug>(leap-forward)')
            vim.keymap.set({ 'x', 'o' }, 'sb', '<Plug>(leap-backward)')
            -- leap.create_default_mappings()
            -- Define equivalence classes for brackets and quotes, in addition to
            -- the default whitespace group.
            leap.opts.equivalence_classes = { ' \t\r\n', '([{', ')]}', '\'"`' }

            -- Use the traversal keys to repeat the previous motion without explicitly
            -- invoking Leap.
            -- user.set_repeat_keys('<enter>', '<backspace>')
        end,
    },
    {
        'folke/flash.nvim',
        enabled = false,
        event = 'VeryLazy',
        opts = {},
        keys = {
            {
                's',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').jump()
                end,
                desc = 'Flash',
            },
            {
                '<leader>s',
                mode = { 'n', 'x', 'o' },
                function()
                    require('flash').treesitter()
                end,
                desc = 'Flash Treesitter',
            },
            {
                'r',
                mode = 'o',
                function()
                    require('flash').remote()
                end,
                desc = 'Remote Flash',
            },
            {
                'R',
                mode = { 'o', 'x' },
                function()
                    require('flash').treesitter_search()
                end,
                desc = 'Treesitter Search',
            },
            {
                '<c-s>',
                mode = { 'c' },
                function()
                    require('flash').toggle()
                end,
                desc = 'Toggle Flash Search',
            },
        },
    },
    {
        'lukas-reineke/indent-blankline.nvim',
        main = 'ibl',
        opts = {},
        config = function()
            local highlight = {
                'RainbowRed',
                'RainbowYellow',
                'RainbowBlue',
                'RainbowOrange',
                'RainbowGreen',
                'RainbowViolet',
                'RainbowCyan',
            }
            local hooks = require('ibl.hooks')
            -- create the highlight groups in the highlight setup hook, so they are reset
            -- every time the colorscheme changes
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
                vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
                vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
                vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
                vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
                vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
                vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
            end)

            vim.g.rainbow_delimiters = { highlight = highlight }
            require('ibl').setup({
                scope = { highlight = highlight },
                exclude = {
                    filetypes = {
                        'dashboard', -- Exclude dashboard buffer by dashboard.nvim
                    },
                },
            })

            hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
        end,
    },
    {
        'kylechui/nvim-surround',
        -- To give mini.surround a try.
        enabled = false,
        version = '*', -- Use for stability; omit to use `main` branch for the latest features
        event = 'VeryLazy',
        config = function()
            require('nvim-surround').setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
    {
        'mbbill/undotree',
        keys = {
            {
                '<leader>tu',
                function()
                    vim.cmd.UndotreeToggle()
                end,
                mode = { 'n' },
                desc = 'Toggle UndoTree',
            },
        },
    },
    {
        'chrisgrieser/nvim-rip-substitute',
        cmd = 'RipSubstitute',
        keys = {
            { '<leader>rs', mode = { 'n', 'x' } },
        },
        config = function()
            larp.fn.map({ 'n', 'x' }, '<leader>rs', function()
                require('rip-substitute').sub()
            end)
        end,
    },
    {
        'cshuaimin/ssr.nvim',
        module = 'ssr',
        -- Calling setup is optional.

        config = function()
            require('ssr').setup({
                border = 'rounded',
                min_width = 50,
                min_height = 5,
                max_width = 120,
                max_height = 25,
                adjust_window = true,
                keymaps = {
                    close = 'q',
                    next_match = 'n',
                    prev_match = 'N',
                    replace_confirm = '<cr>',
                    replace_all = '<leader><cr>',
                },
            })
            larp.fn.map({ 'n', 'x' }, '<leader><leader>rr', function()
                require('ssr').open()
            end, { desc = 'Replace (SSR)' })
        end,
    },
    {
        'smjonas/live-command.nvim',
        -- live-command supports semantic versioning via Git tags
        -- tag = "2.*",
        config = function()
            require('live-command').setup({
                commands = {
                    Norm = { cmd = 'norm' },
                },
            })
        end,
    },
    -- lazy.nvim
    {
        'chrisgrieser/nvim-rip-substitute',
        cmd = 'RipSubstitute',
        keys = {
            {
                '<leader>fs',
                function()
                    require('rip-substitute').sub()
                end,
                mode = { 'n', 'x' },
                desc = ' rip substitute',
            },
        },
    },
    {
        'jake-stewart/multicursor.nvim',
        branch = '1.0',
        config = function()
            local mc = require('multicursor-nvim')

            mc.setup()

            -- Add cursors above/below the main cursor.
            vim.keymap.set({ 'n', 'v' }, '<up>', function()
                mc.addCursor('k')
            end)
            vim.keymap.set({ 'n', 'v' }, '<down>', function()
                mc.addCursor('j')
            end)

            -- Add a cursor and jump to the next word under cursor.
            vim.keymap.set({ 'n', 'v' }, '<c-n>', function()
                mc.addCursor('*')
            end)

            -- Jump to the next word under cursor but do not add a cursor.
            vim.keymap.set({ 'n', 'v' }, '<c-s>', function()
                mc.skipCursor('*')
            end)

            -- Rotate the main cursor.
            vim.keymap.set({ 'n', 'v' }, '<left>', mc.nextCursor)
            vim.keymap.set({ 'n', 'v' }, '<right>', mc.prevCursor)

            -- Delete the main cursor.
            vim.keymap.set({ 'n', 'v' }, '<leader>x', mc.deleteCursor)

            -- Add and remove cursors with control + left click.
            vim.keymap.set('n', '<c-leftmouse>', mc.handleMouse)

            -- vim.keymap.set({ 'n', 'v' }, '<c-q>', function()
            --     if mc.cursorsEnabled() then
            --         -- Stop other cursors from moving.
            --         -- This allows you to reposition the main cursor.
            --         mc.disableCursors()
            --     else
            --         mc.addCursor()
            --     end
            -- end)

            vim.keymap.set('n', '<esc>', function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                elseif mc.hasCursors() then
                    mc.clearCursors()
                else
                    -- Default <esc> handler.
                end
            end)

            -- Align cursor columns.
            vim.keymap.set('n', '<leader>a', mc.alignCursors)

            -- Split visual selections by regex.
            vim.keymap.set('v', 'S', mc.splitCursors)

            -- Append/insert for each line of visual selections.
            vim.keymap.set('v', 'I', mc.insertVisual)
            vim.keymap.set('v', 'A', mc.appendVisual)

            -- match new cursors within visual selections by regex.
            vim.keymap.set('v', 'M', mc.matchCursors)

            -- Rotate visual selection contents.
            vim.keymap.set('v', '<leader>t', function()
                mc.transposeCursors(1)
            end)
            vim.keymap.set('v', '<leader>T', function()
                mc.transposeCursors(-1)
            end)

            -- Customize how cursors look.
            vim.api.nvim_set_hl(0, 'MultiCursorCursor', { link = 'Cursor' })
            vim.api.nvim_set_hl(0, 'MultiCursorVisual', { link = 'Visual' })
            vim.api.nvim_set_hl(0, 'MultiCursorDisabledCursor', { link = 'Visual' })
            vim.api.nvim_set_hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
        end,
    },
    {
        'gennaro-tedesco/nvim-peekup',
    },
    -- lazy.nvim
    {
        'chrisgrieser/nvim-scissors',
        dependencies = { 'nvim-telescope/telescope.nvim', 'garymjr/nvim-snippets' },
        opts = {
            snippetDir = vim.fn.stdpath('config') .. '/snippets',
        },
        config = function()
            vim.keymap.set('n', '<leader>se', function()
                require('scissors').editSnippet()
            end)

            -- when used in visual mode, prefills the selection as snippet body
            vim.keymap.set({ 'n', 'x' }, '<leader>sa', function()
                require('scissors').addNewSnippet()
            end)
        end,
    },
}

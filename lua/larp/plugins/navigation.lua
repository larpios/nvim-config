return {
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
        'nvim-telescope/telescope.nvim',
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
}

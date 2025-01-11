return {
    {
        'LintaoAmons/bookmarks.nvim',
        tag = "v1.4.2", -- optional, pin the plugin at specific version for stability
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
        event = 'VeryLazy',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            { 'junegunn/fzf', build = './install --bin' },
        },
        config = function()
            require('custom.fzf-lua')
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
            require('custom.telescope')
        end
    },
    {
        'ThePrimeagen/harpoon',
        branch = 'harpoon2',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
        },
        config = function()
            local harpoon = require('harpoon')
            local exts = require('harpoon.extensions')
            -- REQUIRED
            harpoon:setup()

            harpoon:extend(exts.builtins.navigate_with_number())

            local conf = require('telescope.config').values
            local function toggle_telescope(harpoon_files)
                local file_paths = {}
                for _, item in ipairs(harpoon_files.items) do
                    table.insert(file_paths, item.value)
                end

                require('telescope.pickers')
                    .new({}, {
                        prompt_title = 'Harpoon',
                        finder = require('telescope.finders').new_table({
                            results = file_paths,
                        }),
                        previewer = conf.file_previewer({}),
                        sorter = conf.generic_sorter({}),
                    })
                    :find()
            end

            vim.keymap.set('n', '<leader><leader>a', function()
                local buf_name = vim.api.nvim_buf_get_name(0)
                harpoon:list():add()
                print('Added ' .. buf_name .. ' to Harpoon')
            end)

            vim.keymap.set('n', '<C-e>', function()
                harpoon.ui:toggle_quick_menu(harpoon:list())
            end)
            -- vim.keymap.set('n', '<C-e>', function()
            --     toggle_telescope(harpoon:list())
            -- end)

            -- Toggle previous & next buffers stored within Harpoon list
            vim.keymap.set('n', '<c-b>', function()
                harpoon:list():prev()
            end)
            vim.keymap.set('n', '<c-f>', function()
                harpoon:list():next()
            end)
        end,
    },
}

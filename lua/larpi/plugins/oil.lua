return {
    'stevearc/oil.nvim',
    lazy = false,
    dependencies = {
        'nvim-mini/mini.icons',
        {
            'JezerM/oil-lsp-diagnostics.nvim',
            opts = {},
        },
        'malewicz1337/oil-git.nvim',
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
    config = function(_, opts)
        require('oil').setup(opts)

        vim.api.nvim_create_autocmd('VimEnter', {
            group = vim.api.nvim_create_augroup('CdIntoArg', { clear = true }),
            desc = "Change directory into the first argument if it's a directory",
            callback = function()
                if vim.fn.argc() > 0 then
                    local arg = vim.fn.argv(0):sub(7, -1)

                    if vim.fn.isdirectory(arg) then
                        vim.api.nvim_set_current_dir(arg)
                    end
                end
            end,
        })
    end,
    cmd = { 'Oil' },
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
}

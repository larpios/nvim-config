local opts = {
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
}

require('oil').setup(opts)

vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory', noremap = true, silent = true })

local my_workspaces = {
    default = '~/notes/norgs',
    personal = '~/notes/norgs/personal',
    work = '~/notes/norgs/work',
}
require('neorg').setup({
    -- Tell Neorg what modules to load
    load = {
        ['core.defaults'] = {}, -- Load all the default modules
        ['core.autocommands'] = {},
        ['core.dirman'] = {
            config = {
                workspaces = my_workspaces,
                index = 'index.norg',
            },
        },
        ['core.concealer'] = {},
        ['core.completion'] = {
            config = {
                name = '[Neorg]',
                engine = 'nvim-cmp',
            },
        }, -- Load all the default modules
        ['core.integrations.nvim-cmp'] = {},
        ['core.integrations.treesitter'] = {},
        ['core.integrations.telescope'] = {
            config = {
                insert_file_link = {
                    show_title_preview = true,
                },
            },
        },
        ['core.presenter'] = {
            config = {
                zen_mode = 'zen-mode',
            },
        },
        ['core.export'] = {
            config = {
                path = '~/norgs/exports',
                export_dir = '<export-dir>/<language>-export',
            },
        },
        ['core.export.markdown'] = {},
        ['core.fs'] = {},
        ['core.neorgcmd'] = {},
        ['core.ui'] = {},
        ['core.neorgcmd.commands.return'] = {},
        ['core.tempus'] = {},
        ['core.syntax'] = {},
        ['core.ui.calendar'] = {},
        ['core.summary'] = {
            config = {
                strategy = 'default',
            },
        },
        ['core.highlights'] = {},
        ['core.clipboard'] = {},
        ['core.queries.native'] = {},
        ['core.todo-introspector'] = {},
        ['core.storage'] = {
            config = {
                vim.fn.stdpath('data') .. '/neorg.mpack',
            },
        },
        ['core.text-objects'] = {},
    },
})
vim.keymap.set('n', '<leader>no', '<cmd>Neorg<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>nw', function()
    vim.ui.select(vim.tbl_keys(my_workspaces), { prompt = 'Workspace: ' }, function(input)
        vim.cmd('Neorg workspace ' .. input)
    end)
end, { noremap = true, silent = true })

vim.keymap.set('n', '<leader>nfh', '<Plug>(neorg.telescope.search_headings)', { desc = 'Find Norg Headings' })
vim.keymap.set('n', '<leader>nff', '<Plug>(neorg.telescope.find_norg_files)', { desc = 'Find Norg Files' })
vim.keymap.set('n', '<leader>nfb', '<Plug>(neorg.telescope.backlinks.file_backlinks)', { desc = 'Find Backlinks' })
vim.keymap.set('n', '<leader>nfB', '<Plug>(neorg.telescope.backlinks.header_backlinks)', { desc = 'Find Header Backlinks' })
vim.keymap.set('n', '<localleader>niL', '<Plug>(neorg.telescope.insert_file_link)', { desc = 'Insert File Link' })
vim.keymap.set('n', '<localleader>nil', '<Plug>(neorg.telescope.insert_link)', { desc = 'Insert Link' })
vim.keymap.set({ 'i', 'x', 'n' }, '<C-@>', '<C-Space>', { noremap = true, silent = true })
vim.keymap.set({ 'i', 'x', 'n' }, '<C-Space>', '<Plug>(neorg.itero.next-iteration)', { desc = 'Continue Current Object', noremap = true, silent = true })

vim.api.nvim_create_autocmd('Filetype', {
    pattern = 'norg',
    callback = function()
        vim.o.conceallevel = 3
        vim.keymap.set('n', '<up>', '<Plug>(neorg.text-objects.item-up)', { desc = 'Move item up' })
        vim.keymap.set('n', '<down>', '<Plug>(neorg.text-objects.item-down)', { desc = 'Move item down' })
        vim.keymap.set({ 'o', 'x' }, 'iH', '<Plug>(neorg.text-objects.textobject.heading.inner)', { desc = 'Select heading' })
        vim.keymap.set({ 'o', 'x' }, 'aH', '<Plug>(neorg.text-objects.textobject.heading.outer)', { desc = 'Select heading' })
        vim.keymap.set({ 'n', 'x' }, '<localleader>T', '<Plug>(neorg.qol.todo-items.todo.task-cycle)', { desc = 'Cycle through Task Modes' })
        vim.keymap.set({ 'i', 'x', 'n' }, '<C-@>', '<C-Space>')
        vim.keymap.set({ 'i', 'x', 'n' }, '<S-CR>', '<Plug>(neorg.itero.next-iteration)', { desc = 'Continue Current Object' })
        vim.keymap.set({ 'i', 'x', 'n' }, '<C-Space>', '<Plug>(neorg.itero.next-iteration)', { desc = 'Continue Current Object' })
        vim.keymap.set({ 'i', 'x', 'n' }, '<C-S-a>', '<Plug>(neorg.itero.next-iteration)', { desc = 'Continue Current Object' })
        vim.keymap.set('', '<localleader>Tc', '<cmd>Neorg toggle-concealer<cr>', { desc = 'Toggle Concealer' })
    end,
})

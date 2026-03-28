return {
    'nvim-orgmode/orgmode',
    ft = { 'org' },
    keys = {
        {
            '<leader>oo',
            function()
                require('orgmode').setup()
                vim.cmd('e ~/obsidian-vault/')
            end,
            desc = 'Open Orgmode',
        },
        {
            '<leader>of',
            function()
                require('fzf-lua').files({ cwd = '~/obsidian-vault/' })
            end,
            desc = 'Find Org Files',
        },
        {
            '<leader>oj',
            function()
                local org_path = '~/obsidian-vault/'
                local today = os.date('*t')
                local journal = org_path .. '/journal/' .. today.year .. '/' .. today.month .. '/' .. today.day .. '.org'
                if vim.fn.filereadable(vim.fn.expand(journal)) == 0 then
                    vim.cmd('silent !mkdir -p ' .. org_path .. '/journal/' .. today.year .. '/' .. today.month)
                    vim.cmd('silent !touch ' .. journal)
                end
                vim.cmd('e ' .. journal)
            end,
            desc = 'Open Org Journal',
        },
    },
    config = function()
        local org_path = '~/obsidian-vault/'
        require('orgmode').setup({
            org_agenda_files = org_path .. '/**/*',
            org_default_notes_file = org_path .. 'refile.org',
            org_startup_indented = true,
            org_fold_enable = false,
            org_startup_folded = 'showeverything',
            mappings = {
                disable_all = true,
            },
        })
        -- Experimental LSP support
        vim.lsp.enable('org')
    end,
}

local opts = {
    workspaces = {
        {
            name = 'default',
            path = '~/notes/obsidian/obsidian-vault',
        },
    },
    templates = {
        folder = 'Templates',
    },
    daily_notes = {
        folder = 'journal',
    },
    completion = {
        nvim_cmp = true,
        min_char = 2,
    },
}
local obsidian = require('obsidian')
obsidian.setup(opts)
require('nvim-treesitter.configs').setup({
    ensure_installed = { 'markdown', 'markdown_inline' },
    highlight = {
        enable = true,
    },
})

larp.fn.map('n', '<leader>Ofw', function()
    vim.ui.select(larp.fn.tbl_get_by_key(opts.workspaces, 'name'), {
        prompt = 'Choose your obsidian vault',
    }, function(_, idx)
        vim.cmd('edit ' .. opts.workspaces[idx]['path'])
    end)
end, { desc = 'Search Obsidian Workspace' })

larp.fn.map('n', '<leader>Off', '<cmd>ObsidianQuickSwitch<cr>', { desc = 'Search Obsidian Vault' })
larp.fn.map('n', '<leader>Ogg', '<cmd>ObsidianSearch<cr>', { desc = 'Grep Obsidian Vault' })
larp.fn.map('n', '<leader>Ot', '<cmd>ObsidianTOC<cr>', { desc = 'Search Obsidian Vault' })

larp.fn.map('n', '<leader>Os', function()
    -- current date and time
    local now = os.date('%Y-%m-%d %H:%M:%S')

    -- commit and push to git
    local output = vim.fn.system('cd ' .. opts.workspaces[1].path .. ' && git add . && git commit -m "Update ' .. now .. '" && git push')
    vim.print(output)
end, { desc = 'Commit and Push Obsidian Vault' })

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    desc = 'Enter Obsidian Vault',
    pattern = '~/notes/obsidian/*',
    callback = function()
        vim.o.conceallevel = 2
    end,
})

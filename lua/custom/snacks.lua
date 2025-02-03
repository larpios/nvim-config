local opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    bufdelete = {}, -- Delete buffers without disrupting window layout.
    indent = { enabled = true },
    input = {}, -- Better `vim.ui.input`.
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    git = {}, -- Git utilities.
    gitbrowse = {}, -- Open the repo of the active file in the browser.
    statuscolumn = { enabled = true },
    toggle = {},
    scope = {}, -- Scope detection based on treesitter or indent.
    words = { enabled = true },
}

local snacks = require('snacks')
local notifier = snacks.notifier
snacks.setup(opts)

larp.fn.map('n', '<leader>Nff', notifier.show_history, { desc = 'Show History', desc_prefix = 'Notifier' })
larp.fn.map('n', '<leader>Gro', snacks.gitbrowse.open, { desc = 'Open in Browser', desc_prefix = 'Git' })

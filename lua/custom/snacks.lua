local opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
}

local snacks = require('snacks')
local notifier = snacks.notifier
snacks.setup(opts)


larp.fn.map('n', '<leader>Nff', notifier.show_history, { desc = 'Show History', desc_prefix = 'Notifier' })

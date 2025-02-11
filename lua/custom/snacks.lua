local opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    bufdelete = {}, -- Delete buffers without disrupting window layout.
    indent = { enabled = true },
    input = {}, -- Better `vim.ui.input`.
    dim = {},
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    git = {}, -- Git utilities.
    gitbrowse = {}, -- Open the repo of the active file in the browser.
    statuscolumn = { enabled = true },
    toggle = {},
    scope = {}, -- Scope detection based on treesitter or indent.
    words = { enabled = true },
    picker = {},
}

local snacks = require('snacks')
local notifier = snacks.notifier
snacks.setup(opts)

larp.fn.map('n', '<leader>Nff', notifier.show_history, { desc = 'Show History', desc_prefix = 'Notifier' })
larp.fn.map('n', '<leader>Gro', snacks.gitbrowse.open, { desc = 'Open in Browser', desc_prefix = 'Git' })

-- Picker
local picker = snacks.picker

-- Find
larp.fn.map('n', '<leader>pp', function()
    picker.pick()
end, { desc = 'Snacks Picker' })
larp.fn.map('n', '<leader>ff', function()
    picker.files()
end, { desc = 'Find Files' })
larp.fn.map('n', '<leader>fc', function()
    picker.files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Find Config Files' })
larp.fn.map('n', '<leader>fh', function()
    picker.help()
end, { desc = 'Find Help' })
larp.fn.map('n', '<leader>:', function() end, { desc = 'Find Commands' })
larp.fn.map('n', '<leader>fn', function()
    picker.notifications()
end, { desc = 'Find Commands' })
larp.fn.map('n', '<leader>fC', function()
    picker.commands()
end, { desc = 'Find Commands' })
larp.fn.map('n', '<leader>fa', function()
    picker.autocmds()
end, { desc = 'Find Help' })
larp.fn.map('n', '<leader>fk', function()
    picker.keymaps()
end, { desc = 'Find Help' })
larp.fn.map('n', '<leader>fF', function()
    picker.smart()
end, { desc = 'Find Files (Smart)' })
larp.fn.map('n', '<leader>fl', function()
    picker.lazy()
end, { desc = 'Find Lazy Specs' })

larp.fn.map('n', '<leader>fr', function()
    picker.recent()
end, { desc = 'Find Lazy Specs' })

larp.fn.map('n', '<leader>fm', function()
    picker.man()
end, { desc = 'Find Man Pages' })

larp.fn.map('n', '<leader>ft', function()
    picker.colorschemes()
end, { desc = 'Find Colorschemes' })

larp.fn.map('n', '<leader>f.', function()
    picker.resume()
end, { desc = 'Find Resume' })

larp.fn.map('n', '<leader>fd', function()
    picker.diagnostics()
end, { desc = 'Find Diagnostics' })

larp.fn.map('n', '<leader>fb', function()
    picker.buffers()
end, { desc = 'Find Buffers' })

larp.fn.map('n', '<leader>fg', function()
    picker.git_files()
end, { desc = 'Find Git Files' })

larp.fn.map('n', '<leader>gb', function()
    picker.git_branches()
end, { desc = 'Find Git Branches' })

larp.fn.map('n', '<leader>gl', function()
    picker.git_log()
end, { desc = 'Find Git Logs' })

larp.fn.map('n', '<leader>gL', function()
    picker.git_log_line()
end, { desc = 'Find Git Log Line' })

larp.fn.map('n', '<leader>gs', function()
    picker.git_status()
end, { desc = 'Find Git Log Line' })

larp.fn.map('n', '<leader>gd', function()
    picker.git_diff()
end, { desc = 'Find Git Diff' })

larp.fn.map('n', '<leader>gg', function()
    picker.pick('grep')
end, { desc = 'Grep' })

larp.fn.map('n', '<leader>gc', function()
    picker.grep({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Grep Config' })

-- Dim
larp.fn.map('n', '<leader>tz', function()
    snacks.dim()
end, { desc = 'Zen Mode' })

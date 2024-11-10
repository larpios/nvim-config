vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- # Windows
larp.fn.map('', '<leader>wd', '<C-w>c', { desc = 'Close Window' })
larp.fn.map('', '<leader>wo', '<C-w>o', { desc = 'Maximize Window' })

-- Navigate Windows
larp.fn.map('', '<leader>wh', '<C-w>h', { desc = 'Move to Left Window' })
larp.fn.map('', '<leader>wj', '<C-w>j', { desc = 'Move to Bottom Window' })
larp.fn.map('', '<leader>wl', '<C-w>l', { desc = 'Move to Right Window' })
larp.fn.map('', '<leader>wk', '<C-w>k', { desc = 'Move to Top Window' })

-- Split Windows
larp.fn.map('', '<leader>sh', '<C-w>v', { desc = 'Split Window to the Left' })
larp.fn.map('', '<leader>sj', '<C-w>s<C-w>j', { desc = 'Split Window to the Bottom' })
larp.fn.map('', '<leader>sk', '<C-w>s', { desc = 'Split Window to the Top' })
larp.fn.map('', '<leader>sl', '<C-w>v<C-w>l', { desc = 'Split Window to the Right' })
larp.fn.map('', '<leader>wx', '<C-w>x', { desc = 'Swap Window to Next' })

-- Resize Windows
larp.fn.map('', '<leader>w+', '<C-w>+', { desc = 'Increase Window Height' })
larp.fn.map('', '<leader>w-', '<C-w>-', { desc = 'Decrease Window Height' })
larp.fn.map('', '<leader>w>', '<C-w>>', { desc = 'Increase Window Width' })
larp.fn.map('', '<leader>w<', '<C-w><', { desc = 'Decrease Window Width' })
larp.fn.map('', '<leader>w=', '<C-w>=', { desc = 'Equal Window Size' })

-- # Buffers
-- Close Buffer
larp.fn.map('n', '<leader>bd', ':bd<CR>', { desc = 'Close Buffer' })

-- # Tabs
larp.fn.map('n', '<leader>Tc', ':tabnew<CR>', { desc = 'New Tab' })
larp.fn.map('n', '<leader>Td', ':tabclose<CR>', { desc = 'Close Tab' })
larp.fn.map('n', '<leader>Tn', ':tabnext<CR>', { desc = 'Go to Next Tab' })
larp.fn.map('n', '<leader>Tp', ':tabprevious<CR>', { desc = 'Go to Previous Tab' })

-- General
larp.fn.map('', '<leader>qq', ':confirm qa<CR>', { desc = 'Exit NeoVim' })
larp.fn.map('', '<leader>ho', ':e ' .. vim.fn.stdpath('config') .. '<CR>', { desc = 'Open Neovim Config' })
larp.fn.map('', '<leader>ww', ':w<CR>', { desc = 'Write to Buffer' })
larp.fn.map('', '<leader>wa', ':wa<CR>', { desc = 'Write All' })
larp.fn.map('', '<leader>wq', ':wq<CR>', { desc = 'Write and Quit' })
larp.fn.map('', '<leader>so', ':so<CR>', { desc = 'Source Current Buffer' })
larp.fn.map('n', '<C-p>', ':bp<CR>', { desc = 'Navigate to Previous Buffer' })
larp.fn.map('n', '<C-n>', ':bn<CR>', { desc = 'Navigate to Next Buffer' })
larp.fn.map('', '<leader>bo', ':!cd ' .. vim.fn.expand('%:p:h') .. '<CR>', { desc = 'Change Directory to Current Buffer', silent = true })
larp.fn.map('n', 'j', vim.v.count > 1 and 'j' or 'gj', { desc = 'Navigate One Line Down' })
larp.fn.map('n', 'k', vim.v.count > 1 and 'k' or 'gk', { desc = 'Navigate One Line Up' })

-- # Terminal
larp.fn.map('n', '<leader>oth', '<leader>sh:term<CR>', { desc = 'Open Terminal to the Left', remap = true })
larp.fn.map('n', '<leader>otj', '<leader>sj:term<CR>', { desc = 'Open Terminal to the Bottom', remap = true })
larp.fn.map('n', '<leader>otk', '<leader>sk:term<CR>', { desc = 'Open Terminal to the Top', remap = true })
larp.fn.map('n', '<leader>otl', '<leader>sl:term<CR>', { desc = 'Open Terminal to the Right', remap = true })
larp.fn.map('t', '<esc><esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })

-- # Edit
larp.fn.map({ 'i', 'x' }, 'zx', '<Esc>')
larp.fn.map('i', '<C-C>', 'ESC') -- Use <C-C> to act as <ESC>
larp.fn.map('', '<leader>y', '"+y', { desc = 'Yank to Clipboard' })
larp.fn.map('', '<leader><leader>p', '"+p', { desc = 'Paste from Clipboard' })
larp.fn.map('', '<leader>p', function()
    -- Get current cursor position: {row, col} (col is 0-based)
    local cursor = vim.api.nvim_win_get_cursor(0)
    local current_col = cursor[2] + 1 -- Convert to 1-based index

    -- Get the current line
    local line = vim.api.nvim_get_current_line()
    local last_col = #line -- Lua's # operator gives the string length

    if current_col == last_col then
        -- Cursor is on the last column; perform a normal paste
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('P', true, false, true), 'n', true)
    else
        -- Cursor is not on the last column; replace character under cursor without affecting registers
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('"_xP', true, false, true), 'n', true)
    end
end, { desc = 'Paste (Without Cutting)' })
larp.fn.map('', '<leader>cR', ':%s/\\<<C-r><C-w>\\>//g<left><left>', { desc = 'Rename All Occurrences' })
larp.fn.map('v', '<', '<gv')
larp.fn.map('v', '>', '>gv')
-- larp.fn.map('n', '<Tab>', 'za', { desc = 'Toggle Fold' })

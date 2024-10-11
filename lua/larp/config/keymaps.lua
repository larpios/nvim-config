-- # Windows
larp.fn.map('', '<leader>wd', '<C-w>c', { desc = 'Close Window' })
larp.fn.map('', '<leader>wo', '<C-w>o', { desc = 'Maximize Window' })

-- Navigate Windows
larp.fn.map('', '<leader>wh', '<C-w>h', { desc = 'Move to Left Window' })
larp.fn.map('', '<leader>wj', '<C-w>j', { desc = 'Move to Bottom Window' })
larp.fn.map('', '<leader>wk', '<C-w>k', { desc = 'Move to Top Window' })
larp.fn.map('', '<leader>wl', '<C-w>l', { desc = 'Move to Right Window' })

-- Split Windows
larp.fn.map('', '<leader>sh', ':vsplit<CR>', { desc = 'Split Window to the Left' })
larp.fn.map('', '<leader>sj', '<cmd>split<cr><C-w>j', { desc = 'Split Window to the Bottom' })
larp.fn.map('', '<leader>sk', ':split<CR>', { desc = 'Split Window to the Top' })
larp.fn.map('', '<leader>sl', ':vsplit<CR><C-w>l', { desc = 'Split Window to the Right' })
larp.fn.map('', '<leader>wx', '<C-w>x', { desc = 'Swap Window to Next' })
-- Resize Windows
larp.fn.map('', '<leader>w+', '<c-w>+', { desc = 'Increase Window Height' })
larp.fn.map('', '<leader>w-', '<c-w>-', { desc = 'Decrease Window Height' })
larp.fn.map('', '<leader>w>', '<c-w>>', { desc = 'Increase Window Width' })
larp.fn.map('', '<leader>w<', '<c-w><', { desc = 'Decrease Window Width' })
larp.fn.map('', '<leader>w=', '<c-w>=', { desc = 'Equal Window Size' })

-- # Tabs
larp.fn.map('n', '<leader>Tc', '<cmd>tabnew<cr>', { desc = 'New Tab' })
larp.fn.map('n', '<leader>Td', '<cmd>tabclose<cr>', { desc = 'Close Tab' })
larp.fn.map('n', '<leader>Tn', '<cmd>tabnext<cr>', { desc = 'Go to Next Tab' })
larp.fn.map('n', '<leader>Tp', '<cmd>tabprevious<cr>', { desc = 'Go to Previous Tab' })

-- General
larp.fn.map('', '<leader>qq', '<cmd>confirm qa<cr>', { desc = 'Exit NeoVim' })
larp.fn.map('', '<leader>oH', '<cmd>e ' .. vim.fn.stdpath('config') .. '<cr>', { desc = 'Open Neovim Config' })
larp.fn.map('', '<leader>wb', '<cmd>w<cr>', { desc = 'Write to Buffer' })
larp.fn.map('', '<leader>wa', '<cmd>wa<cr>', { desc = 'Write All' })
larp.fn.map('', '<leader>wq', '<cmd>wq<cr>', { desc = 'Write and Quit' })
larp.fn.map('', '<leader>so', '<cmd>so<cr>', { desc = 'Source Current Buffer' })
larp.fn.map('n', '<C-p>', '<cmd>bp<cr>', { desc = 'Navigate to Previous Buffer' })
larp.fn.map('n', '<C-n>', '<cmd>bn<cr>', { desc = 'Navigate to Next Buffer' })
larp.fn.map('', '<leader>ob', '<cmd>cd ' .. vim.fn.expand('%:p:h') .. '<cr>', { desc = 'Change Directory to Current Buffer' })
larp.fn.map('n', 'j', vim.v.count > 1 and 'j' or 'gj', { desc = 'Navigate One Line Down' })
larp.fn.map('n', 'k', vim.v.count > 1 and 'k' or 'gk', { desc = 'Navigate One Line Up' })

-- # Terminal
larp.fn.map('n', '<leader>oth', '<leader>sh<cmd>term<cr>', { desc = 'Open Terminal to the Left', remap = true })
larp.fn.map('n', '<leader>otj', '<leader>sj<cmd>term<cr>', { desc = 'Open Terminal to the Bottom', remap = true })
larp.fn.map('n', '<leader>otk', '<leader>sk<cmd>term<cr>', { desc = 'Open Terminal to the Top', remap = true })
larp.fn.map('n', '<leader>otl', '<leader>sl<cmd>term<cr>', { desc = 'Open Terminal to the Right', remap = true })
larp.fn.map('t', '<esc><esc>', '<c-\\><c-n>', { desc = 'Exit Terminal Mode' })

-- # Edit
larp.fn.map({ 'i', 'x' }, 'zx', '<Esc>')
larp.fn.map('i', '<C-C>', 'ESC') -- Use <C-C> to act as <ESC>
larp.fn.map('', '<leader>y', '"+y', { desc = 'Yank to Clipboard' })
larp.fn.map('', '<leader>p', '"_xP', { desc = 'Paste (Without Cutting)' })
larp.fn.map('', '<leader>cR', ':%s/\\<<C-r><C-w>\\>//g<left><left>', { desc = 'Rename All Occurrences' })
larp.fn.map('v', '<', '<gv')
larp.fn.map('v', '>', '>gv')

-- # Objects
larp.fn.map('o', '"', 'i"', { desc = 'Inside Double Quotes' })
larp.fn.map('o', "'", "i'", { desc = 'Inside Single Quotes' })
larp.fn.map('o', '(', 'i(', { desc = 'Inside Parentheses' })
larp.fn.map('o', '{', 'i{', { desc = 'Inside Braces' })
larp.fn.map('o', ',', 't,', { desc = 'Until Comma' })

-- -- Move Lines
-- larp.fn.map('v', 'J', function()
--     return ":m '>" .. (vim.v.count > 1 and vim.v.count or 1) .. '<CR>gv=gv'
-- end, { expr = true, desc = 'Move Selected Line Down' })
-- larp.fn.map('v', 'K', function()
--     return ":m '<" .. (vim.v.count > 1 and -vim.v.count - 1 or -2) .. '<CR>gv=gv'
-- end, { expr = true, desc = 'Move Selected Line Up' })

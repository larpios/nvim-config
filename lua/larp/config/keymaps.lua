vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- # Windows
vim.keymap.set('', '<leader>wd', '<C-w>c', { desc = 'Close Window', noremap = true, silent = true })
vim.keymap.set('', '<leader>wo', '<C-w>o', { desc = 'Maximize Window', noremap = true, silent = true })

-- Navigate Windows
vim.keymap.set('', '<leader>wh', '<C-w>h', { desc = 'Move to Left Window', noremap = true, silent = true })
vim.keymap.set('', '<leader>wj', '<C-w>j', { desc = 'Move to Bottom Window', noremap = true, silent = true })
vim.keymap.set('', '<leader>wl', '<C-w>l', { desc = 'Move to Right Window', noremap = true, silent = true })
vim.keymap.set('', '<leader>wk', '<C-w>k', { desc = 'Move to Top Window', noremap = true, silent = true })

-- Move Windows
vim.keymap.set('', '<leader>wmh', '<C-w>H', { desc = 'Send Window to Left', noremap = true, silent = true })
vim.keymap.set('', '<leader>wmj', '<C-w>J', { desc = 'Send Window to Bottom', noremap = true, silent = true })
vim.keymap.set('', '<leader>wml', '<C-w>L', { desc = 'Send Window to Right', noremap = true, silent = true })
vim.keymap.set('', '<leader>wmk', '<C-w>K', { desc = 'Send Window to Top', noremap = true, silent = true })
vim.keymap.set('', '<leader>wx', '<C-w>x', { desc = 'Swap Window to Next', noremap = true, silent = true })

-- Split Windows
vim.keymap.set('', '<leader>wH', '<C-w>v', { desc = 'Split Window to the Left', noremap = true, silent = true })
vim.keymap.set('', '<leader>wJ', '<C-w>s<C-w>j', { desc = 'Split Window to the Bottom', noremap = true, silent = true })
vim.keymap.set('', '<leader>wK', '<C-w>s', { desc = 'Split Window to the Top', noremap = true, silent = true })
vim.keymap.set('', '<leader>wL', '<C-w>v<C-w>l', { desc = 'Split Window to the Right', noremap = true, silent = true })

-- Resize Windows
vim.keymap.set('', '<leader>w+', '<C-w>+', { desc = 'Increase Window Height', noremap = true, silent = true })
vim.keymap.set('', '<leader>w-', '<C-w>-', { desc = 'Decrease Window Height', noremap = true, silent = true })
vim.keymap.set('', '<leader>w>', '<C-w>>', { desc = 'Increase Window Width', noremap = true, silent = true })
vim.keymap.set('', '<leader>w<', '<C-w><', { desc = 'Decrease Window Width', noremap = true, silent = true })
vim.keymap.set('', '<leader>w=', '<C-w>=', { desc = 'Equal Window Size', noremap = true, silent = true })

-- # Buffers
-- Close Buffer
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { desc = 'Close Buffer', noremap = true, silent = true })

-- # Tabs
vim.keymap.set('n', '<leader>Tc', ':tabnew<CR>', { desc = 'New Tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader>Td', ':tabclose<CR>', { desc = 'Close Tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader>Tn', ':tabnext<CR>', { desc = 'Go to Next Tab', noremap = true, silent = true })
vim.keymap.set('n', '<leader>Tp', ':tabprevious<CR>', { desc = 'Go to Previous Tab', noremap = true, silent = true })

-- General
vim.keymap.set({ 'n', 'x' }, 'Zqq', ':confirm qa<cr>', { desc = 'Exit NeoVim', noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'ZQ', ':qa!<cr>', { desc = 'Exit NeoVim without saving', noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'Zww', ':w<cr>', { desc = 'Write to Buffer', noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'Zwa', ':wa<cr>', { desc = 'Write All', noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'Zwq', ':wq<cr>', { desc = 'Write and Quit', noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'ZwQ', ':wqa<cr>', { desc = 'Write All and Quit', noremap = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<leader>oc', ':e ' .. vim.fn.stdpath('config') .. '<CR>', { desc = 'Open Neovim Config', silent = true })
vim.keymap.set('n', '<leader>so', function()
    vim.notify('Sourced ' .. vim.fn.expand('%:p'))
    vim.cmd('source ' .. vim.fn.expand('%:p'))
end, { desc = 'Source Current Buffer', silent = true })
vim.keymap.set('n', '<C-p>', ':bprevious<cr>', { desc = 'Navigate to Previous Buffer', noremap = true, silent = true })
vim.keymap.set('n', '<C-n>', ':bnext<cr>', { desc = 'Navigate to Next Buffer', noremap = true, silent = true })
vim.keymap.set('', '<leader>bo', function()
    local current_buffer = vim.fn.bufnr('%')
    local path = vim.fn.expand('%:p:h')
    -- if the buffer name starts with oil://
    if vim.fn.bufname(current_buffer):match('^oil://') then
        local result, oil = pcall(require, 'oil')
        if not result then
            vim.notify('Failed to load oil', vim.log.levels.WARN)
            return
        end
        path = oil.get_current_dir()
        if path == nil then
            vim.notify('Failed to get current directory', vim.log.levels.ERROR)
            return
        end
    end
    vim.cmd('cd ' .. path)
    vim.notify('Changed directory to ' .. path)
end, { desc = 'Change Directory to Current Buffer', silent = true })
vim.keymap.set('n', 'j', function()
    if vim.v.count > 1 then
        vim.cmd('normal! ' .. vim.v.count .. 'j')
    else
        vim.cmd('normal! gj')
    end
end, { desc = 'Navigate One Line Down' })
vim.keymap.set('n', 'k', function()
    if vim.v.count > 1 then
        -- If we prefix it with a count, that means we are looking at the relative line number.
        vim.cmd('normal! ' .. vim.v.count .. 'k')
    else
        vim.cmd('normal! gk')
    end
end, { desc = 'Navigate One Line Up' })

-- # Terminal
vim.keymap.set('n', '<leader>oth', function()
    vim.cmd('vsplit | wincmd h | term')
end, { desc = 'Open Terminal to the Left', remap = true })
vim.keymap.set('n', '<leader>otj', function()
    vim.cmd('split | wincmd j | term')
end, { desc = 'Open Terminal to the Bottom', remap = true })
vim.keymap.set('n', '<leader>otk', function()
    vim.cmd('split | term')
end, { desc = 'Open Terminal to the Top', remap = true })
vim.keymap.set('n', '<leader>otl', function()
    vim.cmd('vsplit| wincmd l | term')
end, { desc = 'Open Terminal to the Right', remap = true })
vim.keymap.set('t', '<esc><esc>', '<C-\\><C-n>', { desc = 'Exit Terminal Mode' })

-- # Edit
vim.keymap.set({ 'i', 'x' }, 'zx', '<Esc>')
vim.keymap.set('i', '<C-C>', function()
    vim.cmd('stopinsert')
end) -- Use <C-C> to act as <ESC>
vim.keymap.set('', '<leader>y', function()
    vim.cmd('normal! "+y')
    vim.notify('Yanked to Clipboard')
end, { desc = 'Yank to Clipboard' })
vim.keymap.set('', '<leader><leader>p', '"+p', { desc = 'Paste from Clipboard' })
-- vim.keymap.set({ 'n', 'x' }, 'Q', 'gq', { desc = 'Split long text into multiple lines', noremap = true, silent = true })
vim.keymap.set('', '<leader>p', function()
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
vim.keymap.set('', '<leader>cR', ':%s/\\<<C-r><C-w>\\>//g<left><left>', { desc = 'Rename All Occurrences' })

-- Better Indentation. You can continue pressing < or > to indent more.
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

vim.keymap.set('n', '<leader>lo', function()
    require('larp.utils.orphans').check_orphans()
end, { desc = 'Check for Orphan Plugins', silent = true })

vim.api.nvim_create_user_command('CheckOrphans', function(opts)
    local threshold = tonumber(opts.args)
    require('larp.utils.orphans').check_orphans(threshold)
end, { nargs = '?' })

-- #LSP
vim.keymap.set({ 'n', 'x' }, 'gh', function()
    vim.diagnostic.open_float({
        focusable = true,
        close_events = { 'BufLeave', 'InsertEnter', 'FocusLost' },
        source = true,
    })
end, { desc = 'open diagnostics' })
vim.keymap.set({ 'n', 'x' }, '<leader>ca', function()
    vim.lsp.buf.code_action()
end, { desc = 'Open Diagnostics' })

-- # Misc.

vim.keymap.set('n', '<leader>Co', function()
    local xdg_config_home = os.getenv('XDG_CONFIG_HOME')
    if xdg_config_home == nil then
        xdg_config_home = vim.fn.expand('$HOME') .. '/.config'
    end
    vim.cmd('e ' .. xdg_config_home)
end, { desc = 'Change Directory to XDG_CONFIG_HOME' })

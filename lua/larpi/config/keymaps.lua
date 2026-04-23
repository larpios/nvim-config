vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

-- # Windows
vim.keymap.set('n', '<Leader>wd', function()
    vim.api.nvim_win_close(0, true)
end, { desc = '[Custom] Close Window' })
vim.keymap.set('n', '<Leader>wo', '<Cmd>only<CR>', { desc = '[Custom] Maximize Window' })

-- Navigate Windows
vim.keymap.set('n', '<Leader>wh', '<Cmd>wincmd h<CR>', { desc = '[Custom] Move to Left Window' })
vim.keymap.set('n', '<Leader>wj', '<Cmd>wincmd j<CR>', { desc = '[Custom] Move to Bottom Window' })
vim.keymap.set('n', '<Leader>wl', '<Cmd>wincmd l<CR>', { desc = '[Custom] Move to Right Window' })
vim.keymap.set('n', '<Leader>wk', '<Cmd>wincmd k<CR>', { desc = '[Custom] Move to Top Window' })

-- Move Windows
vim.keymap.set('n', '<Leader>wH', '<Cmd>wincmd H<CR>', { desc = '[Custom] Send Window to Left' })
vim.keymap.set('n', '<Leader>wJ', '<Cmd>wincmd J<CR>', { desc = '[Custom] Send Window to Bottom' })
vim.keymap.set('n', '<Leader>wL', '<Cmd>wincmd L<CR>', { desc = '[Custom] Send Window to Right' })
vim.keymap.set('n', '<Leader>wK', '<Cmd>wincmd K<CR>', { desc = '[Custom] Send Window to Top' })
vim.keymap.set('n', '<Leader>wx', '<Cmd>wincmd x<CR>', { desc = '[Custom] Swap Window to Next' })

-- Split Windows
vim.keymap.set('n', '<Leader>wsh', '<Cmd>leftabove vsplit<CR>', { desc = '[Custom] Split Window to the Left' })
vim.keymap.set('n', '<Leader>wsj', '<Cmd>belowright split<CR>', { desc = '[Custom] Split Window to the Bottom' })
vim.keymap.set('n', '<Leader>wsk', '<Cmd>aboveleft split<CR>', { desc = '[Custom] Split Window to the Top' })
vim.keymap.set('n', '<Leader>wsl', '<Cmd>rightbelow vsplit<CR>', { desc = '[Custom] Split Window to the Right' })

-- Resize Windows
vim.keymap.set('n', '<Leader>w+', '<Cmd>resize +10<CR>', { desc = '[Custom] Increase Window Height' })
vim.keymap.set('n', '<Leader>w-', '<Cmd>resize -10<CR>', { desc = '[Custom] Decrease Window Height' })
vim.keymap.set('n', '<Leader>w>', '<Cmd>vertical resize +10<CR>', { desc = '[Custom] Increase Window Width' })
vim.keymap.set('n', '<Leader>w<', '<Cmd>vertical resize -10<CR>', { desc = '[Custom] Decrease Window Width' })
vim.keymap.set('n', '<Leader>w=', '<Cmd>wincmd =<CR>', { desc = '[Custom] Equal Window Size' })

-- # Buffers
-- Close Buffer
vim.keymap.set('n', '<Leader>bd', '<Cmd>bd<CR>', { desc = '[Custom] Close Buffer' })

-- # Tabs
vim.keymap.set('n', '<Leader>Tc', '<Cmd>tabnew<CR>', { desc = '[Custom] New Tab' })
vim.keymap.set('n', '<Leader>Td', '<Cmd>tabclose<CR>', { desc = '[Custom] Close Tab' })
vim.keymap.set('n', '<Leader>Tn', '<Cmd>tabnext<CR>', { desc = '[Custom] Go to Next Tab' })
vim.keymap.set('n', '<Leader>Tp', '<Cmd>tabprevious<CR>', { desc = '[Custom] Go to Previous Tab' })

-- General
vim.keymap.set({ 'n', 'x' }, 'Zqq', '<Cmd>confirm qa<CR>', { desc = '[Custom] Exit NeoVim' })
vim.keymap.set({ 'n', 'x' }, 'ZQ', '<Cmd>qa!<CR>', { desc = '[Custom] Exit NeoVim without saving' })
vim.keymap.set({ 'n', 'x' }, 'Zww', '<Cmd>w<CR>', { desc = '[Custom] Write to Buffer' })
vim.keymap.set({ 'n', 'x' }, 'Zwa', '<Cmd>wa<CR>', { desc = '[Custom] Write All' })
vim.keymap.set({ 'n', 'x' }, 'Zwq', '<Cmd>wq<CR>', { desc = '[Custom] Write and Quit' })
vim.keymap.set({ 'n', 'x' }, 'ZwQ', '<Cmd>wqa<CR>', { desc = '[Custom] Write All and Quit' })
vim.keymap.set({ 'n', 'x' }, '<Leader>oc', function()
    vim.cmd.edit(vim.fn.stdpath('config'))
end, { desc = '[Custom] Open Neovim Config' })
vim.keymap.set('n', '<Leader>so', function()
    local current_buffer = vim.fn.expand('%:p')
    vim.cmd.source(current_buffer)
    vim.notify('Sourced ' .. current_buffer)
end, { desc = '[Custom] Source Current Buffer' })
vim.keymap.set('n', '<C-p>', '<Cmd>bprevious<CR>', { desc = '[Custom] Navigate to Previous Buffer' })
vim.keymap.set('n', '<C-n>', '<Cmd>bnext<CR>', { desc = '[Custom] Navigate to Next Buffer' })
vim.keymap.set('n', '<Leader>bo', function()
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
    vim.api.nvim_set_current_dir(path)
    vim.notify('Changed directory to ' .. path)
end, { desc = '[Custom] Change Directory to Current Buffer' })
vim.keymap.set({ 'n', 'x' }, 'j', function()
    return vim.v.count > 0 and 'j' or 'gj'
end, { expr = true, desc = '[Custom] Navigate One Line Down' })

vim.keymap.set({ 'n', 'x' }, 'k', function()
    return vim.v.count > 0 and 'k' or 'gk'
end, { expr = true, desc = '[Custom] Navigate One Line Up' })

-- # Terminal
vim.keymap.set('n', '<Leader>oth', '<Cmd>leftabove vsplit | term<CR>', { desc = '[Custom] Open Terminal to the Left' })
vim.keymap.set('n', '<Leader>otj', '<Cmd>belowright split | term<CR>', { desc = '[Custom] Open Terminal to the Bottom' })
vim.keymap.set('n', '<Leader>otk', '<Cmd>aboveleft split | term<CR>', { desc = '[Custom] Open Terminal to the Top' })
vim.keymap.set('n', '<Leader>otl', '<Cmd>rightbelow vsplit | term<CR>', { desc = '[Custom] Open Terminal to the Right' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = '[Custom] Escape' })

-- # Edit
vim.keymap.set({ 'i', 'x' }, 'zx', '<Esc>')
vim.keymap.set({ 'n', 'x' }, '<Leader>y', function()
    vim.cmd.normal('"+y')
    vim.notify('Yanked to Clipboard')
end, { desc = '[Custom] Yank to Clipboard' })

-- Paste without cutting
vim.keymap.set('x', 'p', function()
    local register = vim.v.register

    return '"_c' .. vim.keycode('<C-r>') .. register .. vim.keycode('<Esc>')
end, { desc = '[Custom] Paste (Without Cutting)', remap = true, expr = true })
vim.keymap.set({ 'n', 'x' }, '<Leader>p', '"+p', { desc = '[Custom] Paste from Clipboard' })
-- vim.keymap.set('n', '<Leader>cR', '<Cmd>%s/\\<<C-r><Cmd>wincmd ><CR>', { desc = '[Custom] Rename All Occurrences', remap = true })

-- Better Indentation. You can continue pressing < or > to indent more.
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')

vim.keymap.set('n', '<Leader>lo', function()
    require('larpi.utils.orphans').check_orphans()
end, { desc = '[Custom] Check for Orphan Plugins' })

vim.api.nvim_create_user_command('CheckOrphans', function(opts)
    local threshold = tonumber(opts.args)
    require('larpi.utils.orphans').check_orphans(threshold)
end, { nargs = '?' })

-- #LSP
vim.keymap.set({ 'n', 'x' }, 'gs', function()
    vim.lsp.buf.signature_help()
end, { desc = '[Custom] Function Signature' })
vim.keymap.set({ 'n', 'x' }, 'gh', function()
    vim.diagnostic.open_float({
        focusable = true,
        source = true,
    })
end, { desc = '[Custom] Open Diagnostics' })
vim.keymap.set({ 'n', 'x' }, '<Leader>ca', function()
    vim.lsp.buf.code_action()
end, { desc = '[Custom] Code Action' })

-- # Misc.

vim.keymap.set('n', 'Zrr', function ()
    vim.cmd.mksession({ 'Session.vim', bang = true })
    vim.cmd.restart('source Session.vim')
end, { desc = '[Custom] Restart Neovim' })

vim.keymap.set('n', '<Leader>Co', function()
    local config_dir = os.getenv('XDG_CONFIG_HOME') or vim.fn.getenv('HOME') .. '/.config'
    vim.cmd.edit(config_dir)
end, { desc = '[Custom] Change Directory to XDG_CONFIG_HOME' })

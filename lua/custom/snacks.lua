local opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    bufdelete = { enabled = true }, -- Delete buffers without disrupting window layout.
    indent = { enabled = true },
    input = { enabled = true }, -- Better `vim.ui.input`.
    -- dashboard = {},
    notifier = { enabled = true },
    toggle = { enabled = true },
    quickfile = { enabled = true },
    git = { enabled = true }, -- Git utilities.
    gitbrowse = { enabled = true }, -- Open the repo of the active file in the browser.
    statuscolumn = { enabled = true },
    scope = { enabled = true }, -- Scope detection based on treesitter or indent.
    words = { enabled = true },
    picker = {
        enabled = true,
        formatters = {
            file = {
                filename_first = true,
                truncate = 10000,
            },
        },
        win = {
            input = {
                keys = {
                    ['<a-.>'] = { 'toggle_hidden', mode = { 'i', 'n' } },
                },
            },
        },
    },
    lazygit = { enabled = true },
    scratch = { enabled = true },
    zen = { enabled = true },
}

local snacks = require('snacks')
local notifier = snacks.notifier
snacks.setup(opts)

vim.keymap.set('n', '<leader>Nff', notifier.show_history, { desc = 'Notifier: Show History', silent = true })
vim.keymap.set('n', '<leader>Gro', snacks.gitbrowse.open, { desc = 'Git: Open in Browser', silent = true })

-- Scratch
vim.keymap.set('n', '<leader>st', function()
    snacks.scratch()
end, { desc = 'Snacks: Toggle Scratch Buffer', silent = true })
vim.keymap.set('n', '<leader>ss', snacks.scratch.select, { desc = 'Snacks: Select Scratch Buffer', silent = true })

-- Git
vim.keymap.set({ 'n', 'x' }, '<leader>Gb', snacks.git.blame_line, { desc = 'Git: Blame', silent = true })
vim.keymap.set('n', '<leader>Gr', function()
    print('Git root: ' .. snacks.git.get_root())
end, { desc = 'Git: Blame', silent = true })

-- Picker
local picker = require('snacks.picker')

-- Find
vim.keymap.set('n', '<leader>pp', function()
    picker.pick()
end, { desc = 'Snacks Picker' })
vim.keymap.set('n', '<leader>ff', function()
    picker.files()
end, { desc = 'Find Files' })
vim.keymap.set('n', '<leader>fc', function()
    picker.files({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Find Config Files' })
vim.keymap.set('n', '<leader>fh', function()
    picker.help()
end, { desc = 'Find Help' })
vim.keymap.set('n', '<leader>:', function() end, { desc = 'Find Commands' })
vim.keymap.set('n', '<leader>fn', function()
    picker.notifications()
end, { desc = 'Find Commands' })
vim.keymap.set('n', '<leader>fC', function()
    picker.commands()
end, { desc = 'Find Commands' })
vim.keymap.set('n', '<leader>fa', function()
    picker.autocmds()
end, { desc = 'Find Help' })
vim.keymap.set('n', '<leader>fk', function()
    picker.keymaps()
end, { desc = 'Find Help' })
vim.keymap.set('n', '<leader>fF', function()
    picker.smart()
end, { desc = 'Find Files (Smart)' })
vim.keymap.set('n', '<leader>fl', function()
    picker.lazy()
end, { desc = 'Find Lazy Specs' })

vim.keymap.set('n', '<leader>fr', function()
    picker.recent()
end, { desc = 'Find Lazy Specs' })

vim.keymap.set('n', '<leader>fs', function()
    picker.lsp_symbols()
end, { desc = 'Find Symbols' })

vim.keymap.set('n', '<leader>fS', function()
    picker.lsp_workspace_symbols()
end, { desc = 'Find Workspace Symbols' })

vim.keymap.set('n', '<leader>fm', function()
    picker.man()
end, { desc = 'Find Man Pages' })

vim.keymap.set('n', '<leader>ft', function()
    picker.colorschemes()
end, { desc = 'Find Colorschemes' })

vim.keymap.set('n', '<leader>f.', function()
    picker.resume()
end, { desc = 'Find Resume' })

vim.keymap.set('n', '<leader>fd', function()
    picker.diagnostics()
end, { desc = 'Find Diagnostics' })

vim.keymap.set('n', '<leader>fb', function()
    picker.buffers()
end, { desc = 'Find Buffers' })

vim.keymap.set('n', '<leader>fg', function()
    picker.git_files()
end, { desc = 'Find Git Files' })

vim.keymap.set('n', '<leader>gb', function()
    picker.git_branches()
end, { desc = 'Find Git Branches' })

vim.keymap.set('n', '<leader>gl', function()
    picker.git_log()
end, { desc = 'Find Git Logs' })

vim.keymap.set('n', '<leader>gL', function()
    picker.git_log_line()
end, { desc = 'Find Git Log Line' })

vim.keymap.set('n', '<leader>gs', function()
    picker.git_status()
end, { desc = 'Find Git Log Line' })

vim.keymap.set('n', '<leader>gd', function()
    picker.git_diff()
end, { desc = 'Find Git Diff' })

vim.keymap.set('n', '<leader>gg', function()
    picker.pick('grep')
end, { desc = 'Grep' })

vim.keymap.set({ 'n', 'x' }, '<leader>gw', function()
    picker.grep_word({
        -- live = true,
        args = { '--hidden', '--follow', '--glob', '!*/.git/*', '--no-ignore' },
    })
end, { desc = 'Grep Word' })

vim.keymap.set({ 'n', 'x' }, '<leader>fw', function()
    picker.files({
        search = vim.fn.expand('<cWORD>'),
        live = true,
    })
end, { desc = 'Grep Word' })

vim.keymap.set('n', '<leader>gc', function()
    picker.grep({ cwd = vim.fn.stdpath('config') })
end, { desc = 'Grep Config' })

-- Lazygit
vim.keymap.set('n', '<leader>Gl', function()
    snacks.lazygit()
end, { desc = 'Lazygit' })

-- Notifier

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd('LspProgress', {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params.value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= 'table' then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ('[%3d%%] %s%s'):format(
                        value.kind == 'end' and 100 or value.percentage or 100,
                        value.title or '',
                        value.message and (' **%s**'):format(value.message) or ''
                    ),
                    done = value.kind == 'end',
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
        vim.notify(table.concat(msg, '\n'), 'info', {
            id = 'lsp_progress',
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and ' ' or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

local notifier = snacks.notifier
vim.keymap.set('n', '<leader>nh', function()
    notifier.show_history()
end, { desc = 'Notification History' })

vim.keymap.set('n', '<leader>nd', function()
    notifier.hide()
end, { desc = 'Notification Dismiss' })

-- Bufdelete
vim.keymap.set('n', '<leader>bd', function()
    snacks.bufdelete.other()
end, { desc = 'Notification Dismiss' })

-- toggle
snacks.toggle.line_number():map('<leader>tl')
snacks.toggle.diagnostics():map('<leader>td')
snacks.toggle.inlay_hints():map('<leader>tci')
snacks.toggle.indent():map('<leader>ti')
snacks.toggle.treesitter():map('<leader>tt')

-- Fix for a while
local M = require('snacks.picker.core.main')
M.new = function(opts)
    opts = vim.tbl_extend('force', {
        float = false,
        file = true,
        current = false,
    }, opts or {})
    local self = setmetatable({}, M)
    self.opts = opts
    self.win = vim.api.nvim_get_current_win()
    return self
end
-- Zen
vim.keymap.set('n', '<leader>zz', function()
    snacks.zen()
end, { desc = 'Toggle Zen' })

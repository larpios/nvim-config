local images = {
    'xqc.png',
    'quieres.png',
    'niko_shocked.png',
    'niko_pancake.png',
    'moist.png',
    'ralsei.png',
    'ralsei2.png',
    'juan.png',
    'cat_with_gun.png',
    'terry.png',
}

math.randomseed(os.time())
local logo = vim.fn.stdpath('config') .. '/images/' .. images[math.random(#images)]

---@param width_scale number Percentage of screen width
---@param height_scale number Percentage of screen height
---@param gap_scale number Percentage of screen width
local function get_dashboard_dimens(width_scale, height_scale, gap_scale)
    local gap = math.floor(vim.o.columns * gap_scale)
    local dashboard = {
        width = math.floor(vim.o.columns * width_scale),
        height = math.floor(vim.o.lines * height_scale),
    }
    local image = {
        width = math.floor((dashboard.width - gap) / 2) - 4, -- Increased buffer to prevent wrapping
        height = dashboard.height - 2,
    }

    return {
        dashboard = dashboard,
        image = image,
        gap = gap,
    }
end

local WIDTH_SCALE = 0.8
local HEIGHT_SCALE = 0.7
local GAP_SCALE = 0.12

local function generate_dashboard_sections()
    local dimens = get_dashboard_dimens(WIDTH_SCALE, HEIGHT_SCALE, GAP_SCALE)

    -- Estimate the height of the right pane content to center it vertically
    -- Header: 6 lines, Keys: 10 lines, Startup: 1 line, Version: 1 line, Gaps/Padding: ~10 lines
    local content_height = 28
    local top_padding = math.max(0, math.floor((dimens.dashboard.height - content_height) / 2))

    local version = vim.version()
    local nvim_version = string.format('v%d.%d.%d', version.major, version.minor, version.patch)

    return {
        {
            section = 'terminal',
            cmd = ('chafa %s --symbols all --view-size %dx%d --align center,center'):format(logo, dimens.image.width, dimens.image.height),
            height = dimens.dashboard.height,
            width = dimens.image.width,
        },
        {
            pane = 2,
            height = dimens.dashboard.height,
            width = dimens.image.width,
            { section = 'terminal', cmd = 'echo', height = top_padding },
            { section = 'header', padding = 4 },
            {
                section = 'keys',
                gap = 1,
                padding = 5,
            },
            { section = 'startup' },
            {
                text = {
                    { '󰚐 ', hl = 'footer' },
                    { 'Neovim ', hl = 'footer' },
                    { nvim_version, hl = 'special' },
                },
                align = 'center',
            },
        },
    }
end

return {
    'folke/snacks.nvim',
    lazy = false,
    ---@type snacks.Config
    opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        explorer = {
            replace_netrw = false,
            trash = true,
        },
        bigfile = { enabled = true },
        bufdelete = { enabled = true }, -- Delete buffers without disrupting window layout.
        dashboard = {
            pane_gap = math.floor(vim.o.columns * GAP_SCALE),
            preset = {
                keys = {
                    { icon = ' ', key = 'f', desc = 'Find File', action = ':lua Snacks.picker.files({ hidden = true, ignored = true})' },
                    { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
                    { icon = ' ', key = 'e', desc = 'Explorer', action = ':lua Snacks.explorer()' },
                    { icon = '󱃪 ', key = 'o', desc = 'Oil', action = ':Oil' },
                    { icon = ' ', key = 'g', desc = 'Find Text', action = ":lua Snacks.dashboard.pick('live_grep')" },
                    { icon = ' ', key = 'r', desc = 'Recent Files', action = ":lua Snacks.dashboard.pick('oldfiles')" },
                    { icon = ' ', key = 'c', desc = 'Config', action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
                    { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
                    { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
                    { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
                },
                header = [[
    ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
    ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
    ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
    ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
    ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
            },
            sections = generate_dashboard_sections(),
        },
        indent = { enabled = true },
        input = { enabled = true }, -- Better `vim.ui.input`.
        image = { enabled = true },
        -- dashboard = {},
        notifier = { enabled = true },
        toggle = { enabled = true },
        quickfile = { enabled = true },
        git = { enabled = true }, -- Git utilities.
        gh = { enabled = true },
        gitbrowse = { enabled = true }, -- Open the repo of the active file in the browser.
        statuscolumn = { enabled = true },
        scope = { enabled = true }, -- Scope detection based on treesitter or indent.
        words = { enabled = true },
        picker = {
            enabled = false,
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
            ui_select = true,
            sources = {
                lsp_references = {
                    finder = function(opts, ctx)
                        ctx.picker.seen = {}
                        return require('snacks.picker.source.lsp').references(opts, ctx)
                    end,
                    transform = function(item, ctx)
                        local seen = ctx.picker.seen
                        local id = vim.inspect({ item.text })
                        if seen[id] then
                            return false
                        end
                        seen[id] = true
                        return true
                    end,
                },
            },
        },
        lazygit = { enabled = true },
        scratch = { enabled = true },
        zen = { enabled = true },
        styles = {
            notification = {
                wo = {
                    wrap = true,
                },
            },
        },
    },
    keys = {
        -- Explorer
        {
            '<Leader>te',
            function()
                Snacks.explorer({
                    hidden = true,
                })
            end,
            desc = '[Snacks.Explorer] Explorer',
        },
        -- Scratch
        {
            '<Leader>St',
            function()
                Snacks.scratch()
            end,
            desc = '[Snacks.Scratch] Open Scratch Buffer',
        },
        {
            '<Leader>Ss',
            function()
                Snacks.scratch.select()
            end,
            desc = '[Snacks.Scratch] Select Scratch Buffer',
        },

        -- Notifier
        {
            '<Leader>nh',
            function()
                Snacks.notifier.show_history()
            end,
            desc = '[Snacks.Notifier] Show History',
        },
        {
            '<Leader>nd',
            function()
                Snacks.notifier.hide()
            end,
            desc = '[Snacks.Notifier] Notification Dismiss',
        },

        -- Bufdelete
        {
            '<Leader>bD',
            function()
                Snacks.bufdelete.other()
            end,
            desc = '[Snacks.Bufdelete] Delete Other',
        },

        -- Other
        {
            '<Leader>crf',
            function()
                Snacks.rename.rename_file()
            end,
            desc = '[Snacks.Rename] Rename File',
        },
        {
            '<c-t>',
            function()
                Snacks.terminal()
            end,
            desc = '[Snacks.Terminal] Toggle Terminal',
        },
        {
            ']]',
            function()
                Snacks.words.jump(vim.v.count1)
            end,
            desc = 'Next Reference',
            mode = { 'n', 'x' },
        },
        {
            '[[',
            function()
                Snacks.words.jump(-vim.v.count1)
            end,
            desc = 'Prev Reference',
            mode = { 'n', 'x' },
        },
        {
            '<Leader>,n',
            desc = 'Neovim News',
            function()
                Snacks.win({
                    file = vim.api.nvim_get_runtime_file('doc/news.txt', false)[1],
                    width = 0.6,
                    height = 0.6,
                    wo = {
                        spell = false,
                        wrap = false,
                        signcolumn = 'yes',
                        statuscolumn = ' ',
                        conceallevel = 3,
                    },
                })
            end,
        },
    },
    init = function()
        vim.api.nvim_create_autocmd('User', {
            pattern = 'VeryLazy',
            callback = function()
                -- Create some toggle mappings
                Snacks.toggle.option('spell', { name = 'Spelling' }):map('<Leader>us')
                Snacks.toggle.option('wrap', { name = 'Wrap' }):map('<Leader>uw')
                Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map('<Leader>uL')
                Snacks.toggle.diagnostics():map('<Leader>ud')
                Snacks.toggle.line_number():map('<Leader>ul')
                Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map('<Leader>uc')
                Snacks.toggle.treesitter():map('<Leader>uT')
                Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map('<Leader>ub')
                Snacks.toggle.inlay_hints():map('<Leader>uh')
                Snacks.toggle.indent():map('<Leader>ug')
                Snacks.toggle.dim():map('<Leader>uD')
                Snacks.toggle.animate():map('<Leader>ua')
                Snacks.toggle.profiler():map('<Leader>up')
                Snacks.toggle.zen():map('<Leader>uz')
            end,
        })
    end,
    config = function(_, opts)
        require('snacks').setup(opts)

        vim.api.nvim_create_autocmd('User', {
            pattern = 'OilActionsPost',
            callback = function(event)
                if event.data.actions[1].type == 'move' then
                    Snacks.rename.on_rename_file(event.data.actions[1].src_url, event.data.actions[1].dest_url)
                end
            end,
        })

        vim.api.nvim_create_autocmd('User', {
            pattern = 'MiniFilesActionRename',
            callback = function(event)
                Snacks.rename.on_rename_file(event.data.from, event.data.to)
            end,
        })

        -- Fix for a while
        local M = require('snacks.picker.core.main')
        local old_new = M.new
        M.new = function(new_opts)
            new_opts = vim.tbl_extend('force', {
                float = false,
                file = true,
                current = false,
            }, new_opts or {})
            local self = setmetatable({}, M)
            self.opts = new_opts
            self.win = vim.api.nvim_get_current_win()
            return self
        end

        vim.api.nvim_create_autocmd('VimResized', {
            group = vim.api.nvim_create_augroup('SnacksDashboardResize', { clear = true }),
            callback = function()
                local snacks = package.loaded['snacks']
                if snacks and snacks.config and snacks.config.dashboard then
                    snacks.config.dashboard.pane_gap = math.floor(vim.o.columns * GAP_SCALE)
                    snacks.config.dashboard.sections = generate_dashboard_sections()
                end
                if vim.bo.filetype == 'snacks_dashboard' then
                    require('snacks.dashboard').update()
                end
            end,
        })
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        {
            'folke/todo-comments.nvim',
            optional = true,
            keys = {
                {
                    '<Leader>st',
                    function()
                        Snacks.picker.todo_comments()
                    end,
                    desc = '[Snacks.Picker] Todo',
                },
                {
                    '<Leader>sT',
                    function()
                        Snacks.picker.todo_comments({ keywords = { 'TODO', 'FIX', 'FIXME' } })
                    end,
                    desc = '[Snacks.Picker] Todo/Fix/Fixme',
                },
            },
        },
    },
}

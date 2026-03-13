-- ============================================================
-- pack.lua — vim.pack plugin management (replaces lazy.nvim)
-- Startup plugins load immediately; everything else is wired
-- up via autocmds and keymaps below.
-- ============================================================

local LAZY = { confirm = false }
local LOAD = { confirm = false, load = true }

-- ── Helpers ──────────────────────────────────────────────────

local function pa(name)
    vim.cmd.packadd(name)
end

-- Load one or more plugins, then optionally call setup_fn.
local function safe_call(name, fn)
    local ok, err = pcall(fn)
    if not ok then
        vim.notify(string.format("[vim.pack] Error setting up %s:\n%s", name, err), vim.log.levels.ERROR)
    end
end

local function load(names, setup_fn)
    if type(names) == 'string' then names = { names } end
    for _, name in ipairs(names) do pa(name) end
    if setup_fn then
        safe_call(table.concat(names, ", "), setup_fn)
    end
end

-- Defer execution until after startup (VeryLazy equivalent).
local function later(fn)
    vim.schedule(fn)
end

-- Load plugins once on the given autocmd event(s).
local function on_event(events, names, setup_fn)
    if type(names) == 'string' then names = { names } end
    vim.api.nvim_create_autocmd(events, {
        once = true,
        callback = function()
            for _, name in ipairs(names) do pa(name) end
            if setup_fn then
                safe_call(table.concat(names, ", "), setup_fn)
            end
        end,
    })
end

-- Load plugins once when a specific filetype is opened.
local function on_ft(filetypes, names, setup_fn)
    if type(names) == 'string' then names = { names } end
    if type(filetypes) == 'string' then filetypes = { filetypes } end
    vim.api.nvim_create_autocmd('FileType', {
        pattern = filetypes,
        once = true,
        callback = function()
            for _, name in ipairs(names) do pa(name) end
            if setup_fn then
                safe_call(table.concat(names, ", "), setup_fn)
            end
        end,
    })
end

-- Stub user commands that load plugins on first invocation.
local function lazy_cmd(cmds, names, setup_fn)
    if type(cmds) == 'string' then cmds = { cmds } end
    if type(names) == 'string' then names = { names } end
    for _, cmd in ipairs(cmds) do
        vim.api.nvim_create_user_command(cmd, function(args)
            for _, name in ipairs(names) do pa(name) end
            if setup_fn then setup_fn() end
            for _, c in ipairs(cmds) do
                pcall(vim.api.nvim_del_user_command, c)
            end
            local bang = args.bang and '!' or ''
            local a = args.args ~= '' and (' ' .. args.args) or ''
            vim.cmd(cmd .. bang .. a)
        end, { nargs = '*', bang = true })
    end
end

-- ── 1. Startup plugins (loaded immediately) ──────────────────

vim.pack.add({
    { src = 'https://github.com/catppuccin/nvim',                       name = 'catppuccin' },
    'https://github.com/folke/snacks.nvim',
    'https://github.com/rmagatti/auto-session',
    'https://github.com/jake-stewart/auto-cmdheight.nvim',
    'https://github.com/mrjones2014/smart-splits.nvim',
    'https://github.com/kwkarlwang/bufresize.nvim',
    'https://github.com/echasnovski/mini.nvim',
    { src = 'https://github.com/nvim-treesitter/nvim-treesitter',       version = 'master' },
    'https://github.com/nvim-treesitter/nvim-treesitter-textobjects',
}, LOAD)

-- init-style options that must precede plugin setup
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
vim.o.foldcolumn    = '1'
vim.o.foldlevel     = 99
vim.o.foldlevelstart = 99
vim.o.foldenable    = true
vim.o.cursorline    = true
vim.o.number        = true
vim.o.termguicolors = true

require('auto-session').setup({
    auto_restore    = false,
    suppressed_dirs = { '~/', '~/Downloads', '/' },
})

require('auto-cmdheight').setup({
    max_lines     = 5,
    duration      = 2,
    remove_on_key = true,
    clear_always  = false,
})

require('custom.snacks')
require('custom.smart-splits')
require('custom.mini')
require('custom.treesitter')

-- ── 2. Lazy plugin installation ───────────────────────────────
-- Installed to opt/, not loaded until packadd is called.

vim.pack.add({
    -- colorschemes
    'https://github.com/folke/tokyonight.nvim',
    'https://github.com/xiyaowong/transparent.nvim',

    -- navigation
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/echasnovski/mini.icons',
    'https://github.com/folke/flash.nvim',
    'https://github.com/mikavilpas/yazi.nvim',
    'https://github.com/dmtrKovalenko/fff.nvim',

    -- shared deps
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/MunifTanjim/nui.nvim',
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim', -- run: make
    'https://github.com/junegunn/fzf',
    'https://github.com/hrsh7th/nvim-cmp', -- obsidian.nvim dep

    -- lsp
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/ray-x/lsp_signature.nvim',
    'https://github.com/mrcjkb/rustaceanvim',         -- pin a v6 tag when known
    'https://github.com/saecki/crates.nvim',
    'https://github.com/kevinhwang91/nvim-ufo',
    'https://github.com/kevinhwang91/promise-async',
    'https://github.com/zeioth/garbage-day.nvim',
    'https://github.com/Bekaboo/dropbar.nvim',
    'https://github.com/stevearc/aerial.nvim',
    'https://github.com/p00f/clangd_extensions.nvim',
    'https://github.com/pest-parser/pest.vim',
    'https://github.com/Civitasv/cmake-tools.nvim',
    'https://github.com/VidocqH/lsp-lens.nvim',
    'https://github.com/jmbuhr/otter.nvim',

    -- completion
    'https://github.com/saghen/blink.cmp',            -- pin a v1 tag when known
    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/mikavilpas/blink-ripgrep.nvim',
    'https://github.com/giuxtaposition/blink-cmp-copilot',
    'https://github.com/moyiz/blink-emoji.nvim',

    -- formatter
    'https://github.com/stevearc/conform.nvim',

    -- ui
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/stevearc/overseer.nvim',
    'https://github.com/folke/noice.nvim',
    'https://github.com/rcarriga/nvim-notify',
    'https://github.com/stevearc/dressing.nvim',
    'https://github.com/j-hui/fidget.nvim',
    'https://github.com/nacro90/numb.nvim',
    'https://github.com/petertriho/nvim-scrollbar',
    'https://github.com/folke/trouble.nvim',
    'https://github.com/folke/which-key.nvim',
    'https://github.com/nvim-zh/colorful-winsep.nvim',
    'https://github.com/mawkler/modicator.nvim',
    'https://github.com/nvzone/showkeys',
    'https://github.com/akinsho/bufferline.nvim',
    'https://github.com/mcauley-penney/visual-whitespace.nvim',
    'https://github.com/rachartier/tiny-code-action.nvim',

    -- editing
    'https://github.com/chrisgrieser/nvim-rip-substitute',
    'https://github.com/smjonas/live-command.nvim',
    'https://github.com/chrisgrieser/nvim-scissors',
    'https://github.com/chrisgrieser/nvim-spider',
    'https://github.com/HiPhish/rainbow-delimiters.nvim',
    'https://github.com/ibhagwan/smartyank.nvim',
    'https://github.com/jiaoshijie/undotree',

    -- git
    'https://github.com/lewis6991/gitsigns.nvim',
    'https://github.com/sindrets/diffview.nvim',
    'https://github.com/esmuellert/codediff.nvim',
    'https://github.com/NeogitOrg/neogit',
    'https://github.com/NicholasZolton/neojj',
    'https://github.com/tpope/vim-fugitive',
    'https://github.com/akinsho/git-conflict.nvim',
    'https://github.com/nicolasgb/jj.nvim',

    -- ai
    'https://github.com/monkoose/neocodeium',
    'https://github.com/David-Kunz/gen.nvim',
    'https://github.com/yetone/avante.nvim',           -- run: make
    'https://github.com/zbirenbaum/copilot.lua',
    'https://github.com/nickjvandyke/opencode.nvim',

    -- utils
    'https://github.com/lambdalisue/vim-suda',
    'https://github.com/MagicDuck/grug-far.nvim',
    'https://github.com/rmagatti/goto-preview',
    'https://github.com/stevearc/quicker.nvim',
    'https://github.com/NMAC427/guess-indent.nvim',
    'https://github.com/kevinhwang91/nvim-bqf',
    'https://github.com/meznaric/key-analyzer.nvim',
    'https://github.com/atiladefreitas/dooing',
    'https://github.com/RaafatTurki/hex.nvim',
    'https://github.com/ZWindL/orphans.nvim',
    'https://github.com/uga-rosa/ccc.nvim',
    'https://github.com/alex-popov-tech/store.nvim',
    'https://github.com/OXY2DEV/markview.nvim',

    -- integrations
    'https://github.com/iamcco/markdown-preview.nvim', -- run: vim.fn['mkdp#util#install']()
    'https://github.com/toppair/peek.nvim',            -- run: deno task --quiet build:fast
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    { src = 'https://github.com/chomosuke/typst-preview.nvim', version = 'v1.4.1' },
    'https://github.com/nvim-orgmode/orgmode',
    'https://github.com/epwalsh/obsidian.nvim',
    'https://github.com/hat0uma/csvview.nvim',

    -- dev
    'https://github.com/akinsho/toggleterm.nvim',
    'https://github.com/mfussenegger/nvim-dap',
    'https://github.com/rcarriga/nvim-dap-ui',
    'https://github.com/nvim-neotest/nvim-nio',
    'https://github.com/theHamsta/nvim-dap-virtual-text',
    'https://github.com/folke/todo-comments.nvim',
    'https://github.com/folke/lazydev.nvim',
}, LAZY)

-- ── 3. Modularized plugin loading ─────────────────────────────

require('larp.plugins.lsp')(load, on_event, on_ft, lazy_cmd, later)
require('larp.plugins.ui')(load, on_event, on_ft, lazy_cmd, later)
require('larp.plugins.editing')(load, on_event, on_ft, lazy_cmd, later)
require('larp.plugins.misc')(load, on_event, on_ft, lazy_cmd, later)

-- ── 4. Keymaps that lazy-load their plugin ───────────────────

-- oil.nvim
local oil_ready = false
vim.keymap.set('n', '-', function()
    if vim.bo.buftype ~= '' then return end
    if not oil_ready then
        oil_ready = true
        load({ 'oil.nvim', 'mini.icons' }, function()
            require('oil').setup({
                default_file_explorer = true,
                delete_to_trash       = true,
                use_default_keymaps   = false,
                keymaps = {
                    ['g?']   = 'actions.show_help',
                    ['<CR>'] = 'actions.select',
                    ['-']    = 'actions.parent',
                    ['<C-v>'] = { 'actions.select', opts = { vertical = true },   desc = 'Open in vertical split' },
                    ['<C-g>'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open in horizontal split' },
                    ['<C-p>'] = 'actions.preview',
                    ['<C-c>'] = 'actions.close',
                    ['<F5>']  = 'actions.refresh',
                    ['_']     = 'actions.open_cwd',
                    ['`']     = 'actions.cd',
                    ['gs']    = 'actions.change_sort',
                    ['gx']    = 'actions.open_external',
                    ['g.']    = 'actions.toggle_hidden',
                    ['g\\']   = 'actions.toggle_trash',
                },
                watch_for_changes = true,
                view_options = {
                    show_hidden = true,
                    sort = { { 'type', 'desc' }, { 'name', 'asc' } },
                },
                columns = { 'icon', 'mtime', 'size', 'permissions' },
                win_options = {
                    wrap   = true,
                    winbar = "%{v:lua.require('oil').get_current_dir()}",
                },
            })
        end)
    end
    vim.schedule(function() require('oil').open() end)
end, { desc = 'Open parent directory' })

-- flash.nvim
local flash_ready = false
local function ensure_flash(fn)
    return function()
        if not flash_ready then
            flash_ready = true
            load({ 'flash.nvim' }, function()
                require('flash').setup({ modes = { char = { jump_labels = true } } })
            end)
        end
        fn()
    end
end
vim.keymap.set({ 'n', 'x', 'o' }, 's', ensure_flash(function() require('flash').jump() end),             { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', ensure_flash(function() require('flash').treesitter() end),       { desc = 'Flash Treesitter' })
vim.keymap.set('o',               'r', ensure_flash(function() require('flash').remote() end),            { desc = 'Remote Flash' })
vim.keymap.set({ 'o', 'x' },      'R', ensure_flash(function() require('flash').treesitter_search() end), { desc = 'Treesitter Search' })
vim.keymap.set('c',          '<c-s>', ensure_flash(function() require('flash').toggle() end),             { desc = 'Toggle Flash Search' })

-- yazi.nvim
local yazi_ready = false
vim.keymap.set({ 'n', 'v' }, '<leader>ty', function()
    if not yazi_ready then
        yazi_ready = true
        load({ 'yazi.nvim', 'plenary.nvim' }, function()
            vim.g.loaded_netrwPlugin = 1
            require('yazi').setup({
                open_for_directories = false,
                keymaps = { show_help = '<f1>' },
            })
        end)
    end
    vim.schedule(function() vim.cmd('Yazi') end)
end, { desc = 'Open yazi at the current file' })

-- fff.nvim
local fff_ready = false
local function fff_action(fn)
    return function()
        if not fff_ready then
            fff_ready = true
            load({ 'fff.nvim' }, function()
                require('fff.download').download_or_build_binary()
                require('fff').setup({
                    prompt  = '❯ ',
                    preview = { enabled = true, line_numbers = true, wrap_lines = true },
                    keymaps = {
                        close = '<Esc>', select = '<CR>', select_split = '<C-s>',
                        select_vsplit = '<C-v>', select_tab = '<C-t>',
                        move_up = { '<Up>', '<C-p>' }, move_down = { '<Down>', '<C-n>' },
                        preview_scroll_up = '<C-u>', preview_scroll_down = '<C-d>',
                        toggle_debug = '<F2>', cycle_grep_modes = '<S-Tab>',
                        cycle_previous_query = '<C-Up>', toggle_select = '<Tab>',
                        send_to_quickfix = '<C-q>', focus_list = '<leader>l',
                        focus_preview = '<leader>p',
                    },
                    debug = { enabled = true, show_scores = true },
                })
            end)
        end
        fn()
    end
end
vim.keymap.set('n', '<leader>ff', fff_action(function() require('fff').find_files() end),                             { desc = 'FFFind files' })
vim.keymap.set('n', '<leader>fc', fff_action(function() require('fff').find_files({ base_path = vim.fn.stdpath('config') }) end), { desc = 'FFFind files (config)' })
vim.keymap.set('n', '<leader>fg', fff_action(function() require('fff').live_grep() end),                              { desc = 'LiFFFe grep' })
vim.keymap.set('n', '<leader>fG', fff_action(function() require('fff').live_grep({ grep = { modes = { 'fuzzy', 'plain' } } }) end), { desc = 'Live fffuzy grep' })
vim.keymap.set('n', '<leader>fw', fff_action(function() require('fff').live_grep({ query = vim.fn.expand('<cword>') }) end), { desc = 'Search current word' })

-- trouble.nvim
local function trouble_action(subcmd)
    return function()
        load({ 'trouble.nvim' }, function() require('trouble').setup({}) end)
        vim.schedule(function() vim.cmd('Trouble ' .. subcmd) end)
    end
end
vim.keymap.set('n', '<leader>xx', trouble_action('diagnostics toggle'),                         { desc = 'Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>xX', trouble_action('diagnostics toggle filter.buf=0'),            { desc = 'Buffer Diagnostics (Trouble)' })
vim.keymap.set('n', '<leader>cs', trouble_action('symbols toggle focus=false'),                 { desc = 'Symbols (Trouble)' })
vim.keymap.set('n', '<leader>cl', trouble_action('lsp toggle focus=false win.position=right'),  { desc = 'LSP Definitions (Trouble)' })
vim.keymap.set('n', '<leader>xL', trouble_action('loclist toggle'),                             { desc = 'Location List (Trouble)' })
vim.keymap.set('n', '<leader>xQ', trouble_action('qflist toggle'),                              { desc = 'Quickfix List (Trouble)' })

-- mason
vim.keymap.set('n', '<leader>mm', function()
    load({ 'mason.nvim' }, function() require('mason').setup({}) end)
    vim.schedule(function() vim.cmd('Mason') end)
end, { desc = 'Mason', silent = true })

-- rip-substitute
local rs_ready = false
local function rs_action()
    if not rs_ready then
        rs_ready = true
        load({ 'nvim-rip-substitute' }, function() require('rip-substitute').setup({}) end)
    end
    vim.schedule(function() require('rip-substitute').sub() end)
end
vim.keymap.set({ 'n', 'x' }, '<leader>rr', rs_action)
vim.keymap.set({ 'n', 'x' }, '<leader>fs', rs_action, { desc = ' rip substitute' })

-- undotree
vim.keymap.set('n', '<leader>tu', function()
    load({ 'undotree' }, function() require('undotree').setup({}) end)
    vim.schedule(function() require('undotree').toggle() end)
end)

-- neogit
vim.keymap.set('n', '<leader>Go', function()
    load({ 'neogit', 'plenary.nvim', 'diffview.nvim', 'fzf-lua' }, function()
        require('custom.neogit')
    end)
    vim.schedule(function() vim.cmd('Neogit') end)
end)

-- jj.nvim
vim.keymap.set('n', '<leader>Gj', function()
    load({ 'neojj', 'plenary.nvim', 'codediff.nvim' })
    vim.schedule(function() vim.cmd('Neojj') end)
end, { desc = 'Show Neojj UI' })

-- scissors
local scissors_ready = false
local function ensure_scissors()
    if not scissors_ready then
        scissors_ready = true
        load({ 'nvim-scissors' }, function()
            require('scissors').setup({ snippetDir = vim.fn.stdpath('config') .. '/snippets' })
        end)
    end
end
vim.keymap.set('n', '<leader>se', function()
    ensure_scissors()
    vim.schedule(function() require('scissors').editSnippet() end)
end, { desc = '[Scissors]  edit snippet' })
vim.keymap.set({ 'n', 'x' }, '<leader>sa', function()
    ensure_scissors()
    vim.schedule(function() require('scissors').addNewSnippet() end)
end, { desc = '[Scissors]  add new snippet' })

-- toggleterm
local toggleterm_ready = false
vim.keymap.set({ 'n', 't', 'i' }, '<c-t>', function()
    if not toggleterm_ready then
        toggleterm_ready = true
        load({ 'toggleterm.nvim' }, function()
            require('toggleterm').setup({ open_mapping = [[<c-t>]] })
        end)
    end
    vim.schedule(function()
        vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<c-t>', true, false, true), 'n', false)
    end)
end)

-- obsidian keymaps (stubs until ObsidianXxx commands are first called via lazy_cmd above)
vim.keymap.set('n', '<leader>Off', '<cmd>ObsidianQuickSwitch<cr>', { desc = 'Search Obsidian Vault' })
vim.keymap.set('n', '<leader>Ogg', '<cmd>ObsidianSearch<cr>',      { desc = 'Grep Obsidian Vault' })
vim.keymap.set('n', '<leader>Ot',  '<cmd>ObsidianTOC<cr>',         { desc = 'Search Obsidian TOC' })
vim.keymap.set('n', '<leader>Oft', '<cmd>ObsidianTags<cr>',        { desc = 'Find Obsidian Tags' })
vim.keymap.set('n', '<leader>Oj',  '<cmd>ObsidianDailies<cr>',     { desc = 'Obsidian Journal' })

-- vim.pack update keymap (replaces <leader>ll for Lazy)
larp.fn.map('n', '<leader>lu', function() vim.pack.update() end, { desc = 'Update plugins (vim.pack)' })

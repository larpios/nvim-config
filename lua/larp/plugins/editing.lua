return function(load, on_event, on_ft, lazy_cmd, later)
    -- BufRead: editing infrastructure
    on_event('BufRead', { 'nvim-ufo', 'promise-async' }, function()
        require('custom.nvim-ufo')
    end)

    on_event('BufRead', { 'gitsigns.nvim' }, function()
        require('custom.gitsigns')
    end)

    on_event('BufRead', { 'git-conflict.nvim' }, function()
        require('git-conflict').setup({})
    end)

    on_event('BufRead', { 'aerial.nvim', 'nvim-treesitter' }, function()
        require('custom.aerial')
    end)

    on_event('BufRead', { 'nvim-scrollbar' }, function()
        require('scrollbar').setup({})
    end)

    on_event('BufRead', { 'nvim-spider' }, function()
        require('custom.nvim-spider')
    end)

    on_event('BufRead', { 'todo-comments.nvim', 'plenary.nvim' }, function()
        require('custom.todo-comments')
    end)

    on_event('BufRead', { 'goto-preview' }, function()
        require('goto-preview').setup({ default_mappings = true })
    end)

    -- ModeChanged: visual whitespace indicator
    on_event({ 'ModeChanged' }, { 'visual-whitespace.nvim' }, function()
        require('visual-whitespace').setup({})
    end)

    -- Deferred editing utils
    later(function()
        load({ 'numb.nvim' }, function()
            require('numb').setup({})
        end)
        load({ 'which-key.nvim' }, function()
            require('custom.which-key')
        end)
        load({ 'grug-far.nvim' }, function()
            require('grug-far').setup({})
        end)
        load({ 'guess-indent.nvim' }, function()
            require('guess-indent').setup({})
        end)
        load({ 'orphans.nvim' }, function()
            require('orphans').setup({})
        end)
        load({ 'rainbow-delimiters.nvim' })
        load({ 'smartyank.nvim' }, function()
            require('smartyank').setup({
                highlight = { enabled = true, higroup = 'IncSearch', timeout = 200 },
                osc52     = { enabled = true, ssh_only = true, silent = false },
                clipboard = { enabled = false },
            })
        end)
        load({ 'live-command.nvim' }, function()
            require('live-command').setup({ commands = { Norm = { cmd = 'norm' } } })
        end)
        load({ 'conform.nvim' }, function()
            require('custom.conform')
        end)
        load({ 'fzf-lua', 'plenary.nvim' }, function()
            require('custom.fzf-lua')
        end)
        load({ 'transparent.nvim' }, function()
            require('custom.transparent')
        end)
    end)

    -- Command stubs
    lazy_cmd({ 'RipSubstitute' }, { 'nvim-rip-substitute' }, function()
        require('rip-substitute').setup({})
    end)
end

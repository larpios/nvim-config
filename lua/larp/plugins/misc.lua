return function(load, on_event, on_ft, lazy_cmd, later)
    -- BufRead: DAP infrastructure
    on_event('BufRead', { 'nvim-dap', 'nvim-dap-ui', 'nvim-nio', 'nvim-dap-virtual-text' }, function()
        require('custom.nvim-dap')
    end)

    -- Deferred AI tools
    later(function()
        load({ 'neocodeium' }, function()
            local neocodeium = require('neocodeium')
            neocodeium.setup()
            vim.keymap.set('i', '<A-a>', neocodeium.accept)
        end)
        load({ 'gen.nvim' }, function()
            require('gen').setup({
                model       = 'deepseek-coder-v2:lite',
                quit_map    = 'q',
                show_prompt = false,
                show_model  = false,
            })
        end)
        load({ 'avante.nvim', 'dressing.nvim' }, function()
            require('avante').setup({
                provider  = 'ollama',
                providers = {
                    ollama = {
                        __inherited_from = 'openai',
                        api_key_name     = '',
                        endpoint         = 'http://127.0.0.1:11434/v1',
                        model            = 'deepseek-coder-v2:lite',
                    },
                },
                auto_set_keymaps = false,
                mappings = { edit = '<C-e>', jump_next = ']a', jump_prev = '[a' },
            })
        end)
        load({ 'opencode.nvim' }, function()
            vim.g.opencode_opts = {}
            vim.o.autoread = true
            vim.keymap.set({ 'n', 'x' }, '<leader>aoa', function()
                require('opencode').ask('@this: ', { submit = true })
            end, { desc = '[Opencode] Ask opencode' })
        end, { desc = '[Opencode] Scroll down' })
    end)

    -- Filetype-based loading
    on_ft('qf', { 'quicker.nvim' }, function()
        require('custom.quicker')
    end)
    on_ft('qf', { 'nvim-bqf', 'fzf' }, function()
        require('bqf').setup({})
    end)
    on_ft({ 'markdown', 'vimwiki' }, { 'render-markdown.nvim' }, function()
        local ok, obsidian = pcall(require, 'obsidian')
        if ok then
            obsidian.get_client().opts.ui.enable = false
            vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces()['ObsidianUI'], 0, -1)
        end
        require('render-markdown').setup({
            completions = { lsp = { enabled = true }, blink = { enabled = true } },
        })
    end)
    on_ft('typst', { 'typst-preview.nvim' }, function()
        require('typst-preview').setup({})
    end)
    on_ft('org', { 'orgmode' }, function()
        require('custom.orgmode')
    end)
    on_ft('csv', { 'csvview.nvim' }, function()
        require('csvview').setup({
            parser = { comments = { '#', '//' } },
            keymaps = {
                textobject_field_inner = { 'if', mode = { 'o', 'x' } },
                textobject_field_outer = { 'af', mode = { 'o', 'x' } },
                jump_next_field_end    = { '<Tab>',   mode = { 'n', 'v' } },
                jump_prev_field_end    = { '<S-Tab>', mode = { 'n', 'v' } },
                jump_next_row          = { '<Enter>',   mode = { 'n', 'v' } },
                jump_prev_row          = { '<S-Enter>', mode = { 'n', 'v' } },
            },
        })
    end)

    -- Command stubs
    lazy_cmd({ 'Neogit', 'NeogitCommit', 'NeogitLogCurrent', 'NeogitResetState' },
        { 'neogit', 'plenary.nvim', 'diffview.nvim', 'fzf-lua' },
        function() require('custom.neogit') end)
    lazy_cmd({ 'ObsidianNew', 'ObsidianOpen', 'ObsidianSearch', 'ObsidianQuickSwitch',
        'ObsidianTOC', 'ObsidianTags', 'ObsidianDailies' },
        { 'obsidian.nvim', 'plenary.nvim', 'nvim-cmp', 'fzf-lua' },
        function() require('custom.obsidian') end)
end

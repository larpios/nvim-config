return function(load, on_event, on_ft, lazy_cmd, later)
    -- InsertEnter: completion + copilot
    on_event('InsertEnter', {
        'blink.cmp', 'friendly-snippets', 'blink-ripgrep.nvim',
        'blink-cmp-copilot', 'blink-emoji.nvim',
    }, function()
        require('custom.blink')
    end)

    on_event('InsertEnter', { 'copilot.lua' }, function()
        require('custom.copilot-lua')
    end)

    -- LspAttach: LSP-dependent UI
    on_event('LspAttach', { 'lsp_signature.nvim' }, function()
        require('lsp_signature').setup({
            bind = true,
            handle_opts = { border = 'rounded' },
        })
    end)

    on_event('LspAttach', { 'lsp-lens.nvim' }, function()
        require('lsp-lens').setup({})
    end)

    on_event('LspAttach', { 'dropbar.nvim', 'telescope-fzf-native.nvim' }, function()
        local api = require('dropbar.api')
        vim.keymap.set('n', '<Leader>;', api.pick,                { desc = 'Pick symbols in winbar' })
        vim.keymap.set('n', '[;',        api.goto_context_start,  { desc = 'Go to start of current context' })
        vim.keymap.set('n', '];',        api.select_next_context, { desc = 'Select next context' })
    end)

    on_event('LspAttach', { 'tiny-code-action.nvim', 'plenary.nvim', 'fzf-lua' }, function()
        require('tiny-code-action').setup({})
        vim.keymap.set('n', '<leader>ca', function()
            require('tiny-code-action').code_action()
        end, { desc = 'Code Action', noremap = true, silent = true })
    end)

    -- Filetype-based loading
    vim.g.rustaceanvim = {
        server = {
            on_attach = function(_, bufnr)
                vim.keymap.set('n', '<leader>a', function()
                    vim.cmd.RustLsp('codeAction')
                end, { silent = true, buffer = bufnr, desc = 'Rust Code Action' })
            end,
        },
    }
    on_ft('rust', { 'rustaceanvim' })

    on_ft('toml', { 'crates.nvim' }, function()
        require('crates').setup({ completion = { cmp = { enabled = false }, blink = { enabled = true } } })
    end)

    on_ft({ 'c', 'cpp' }, { 'clangd_extensions.nvim' }, function()
        require('clangd_extensions').setup({})
    end)

    on_ft('lua', { 'lazydev.nvim' }, function()
        require('lazydev').setup({
            library = { { path = '${3rd}/luv/library', words = { 'vim%.uv' } } },
        })
    end)

    -- Command stubs
    lazy_cmd({ 'Mason', 'MasonInstall', 'MasonLog', 'MasonUninstall', 'MasonUninstallAll', 'MasonUpdate' },
        { 'mason.nvim' }, function()
            require('mason').setup({})
        end)
end

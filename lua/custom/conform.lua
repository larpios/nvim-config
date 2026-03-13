local conform = require('conform')
conform.setup({
    formatters_by_ft = {
        bash = { 'beautysh', 'shfmt', 'shellharden' },
        c = { 'clang_format' },
        cmake = { 'cmake_format' },
        cpp = { 'clang_format' },
        cs = { 'csharpier', 'clang_format' },
        fish = { 'fish_lsp' },
        js = { 'prettier', 'eslint_d' },
        lua = { 'stylua' },
        markdown = { 'injected', 'prettier', 'markdownfmt', 'markdownlint', 'markdownlint-cli2' },
        nix = { 'injected', 'alejandra', 'nixpkgs-fmt', 'nixfmt' },
        nushell = { 'nufmt' },
        org = { 'injected', 'orgfmt' },
        python = { 'ruff', 'autopep8', 'autoflake', 'black' },
        rust = { 'rustfmt' },
        svelte = { 'prettier', 'eslint_d' },
        text = { 'autocorrect' },
        ts = { 'prettier', 'eslint_d' },
        typst = { 'prettypst', 'typstyle' },
        xml = { 'xmlformat' },
        yaml = { 'yamllint', 'prettier' },
    },
    default_format_opts = {
        lsp_format = 'fallback',
    },
    -- format_after_save = {
    --     lsp_format = 'fallback',
    --     timeout_ms = 500,
    -- },
    -- Conform will notify you when no formatters are available for the buffer
    notify_no_formatters = true,
})

vim.api.nvim_create_autocmd({ 'LspAttach' }, {
    pattern = '*',
    callback = function()
        larp.fn.map('n', '<leader>cf', function()
            conform.format({ lsp_fallback = true })
        end, { desc = 'Format Document' })
    end,
})

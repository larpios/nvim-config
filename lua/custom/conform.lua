require('conform').setup({
    formatters_by_ft = {
        lua = { 'stylua' },
        rust = { 'rustfmt' },
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        cmake = { 'cmake_format' },
        nix = { 'nixpkgs_fmt', 'nixfmt' },
        python = { 'autopep8', 'autoflake', 'black' },
        markdown = { 'prettier', 'markdownfmt', 'markdownlint', 'markdownlint-cli2' },
        xml = { 'xmlformat' },
        yaml = { 'yamllint', 'prettier' },
        text = { 'autocorrect' },
        ['*'] = { 'autocorrect', 'codespell' },
        ['_'] = { 'trim_whitespace' },
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
-- larp.fn.map('n', '<leader>cf', require('conform').format)

return {
    -- Formatter
    'stevearc/conform.nvim',
    event = { 'BufRead' },
    cmd = { 'ConformInfo' },
    opts = {
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
            nu = { 'injected', 'nufmt' },
            org = { 'injected', 'orgfmt' },
            python = { 'ruff', 'autopep8', 'autoflake', 'black' },
            rust = { 'rustfmt' },
            svelte = { 'prettier', 'eslint_d' },
            text = { 'autocorrect' },
            ts = { 'prettier', 'eslint_d' },
            typst = { 'prettypst', 'typstyle' },
            xml = { 'xmlformat' },
            yaml = { 'prettier', 'yamlfmt' },
            kdl = { 'kdlfmt' },
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
            notify_on_error = true,
        },
        keys = {
            {
                '<leader>cf',
                function()
                    require('conform').format({
                        async = true, -- might cause a problem where your changes are overwritten by the formatter
                        lsp_format = 'fallback',
                    }, function(err, did_edit)
                        if err == nil then
                            if did_edit then
                                vim.notify('[Conform] Formatted document successfully')
                            else
                                vim.notify('[Conform] Nothing to format')
                            end
                        else
                            vim.notify('[Conform] Error while formatting: ' .. err, vim.log.levels.ERROR)
                        end
                    end)
                end,
                desc = '[Conform] Format Document',
            },
        },
    }

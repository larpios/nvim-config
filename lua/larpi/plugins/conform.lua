return {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'ConformInfo' },
    opts = {
        formatters_by_ft = {
            bash = { 'shfmt', 'shellharden', stop_after_first = true },
            c = { 'clang_format' },
            cmake = { 'clang_format' },
            cpp = { 'clang_format' },
            fish = { 'fish_lsp' },
            javascript = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
            lua = { 'stylua', 'luaformatter', stop_after_first = true },
            markdown = { 'injected', 'prettierd', 'prettier', 'markdownfmt', stop_after_first = true },
            nix = { 'injected', 'alejandra', 'nixpkgs-fmt', 'nixfmt', stop_after_first = true },
            org = { 'injected', 'orgfmt' },
            python = { 'ruff_organize_imports', 'ruff_format' },
            rust = { 'rustfmt' },
            typescript = { 'oxfmt', 'prettierd', 'prettier', stop_after_first = true },
            typst = { 'prettypst', 'typstyle', stop_after_first = true },
            kdl = { 'kdlfmt' },
        },
        default_format_opts = {
            lsp_format = 'fallback',
        },
    },
    keys = {
        {
            '<leader>cf',
            function()
                require('conform').format({ async = true }, function(err)
                    if err then
                        vim.notify('[Conform] ' .. err, vim.log.levels.ERROR)
                        return
                    end

                    -- Fetch the formatters that were actually used for the current buffer
                    local info = require('conform').list_formatters(0)
                    local names = {}
                    for _, f in ipairs(info) do
                        if f.available then
                            table.insert(names, f.name)
                        end
                    end

                    if #names > 0 then
                        vim.notify('[Conform] Formatted with: ' .. table.concat(names, ', '))
                    else
                        vim.notify('[Conform] No formatter available')
                    end
                end)
            end,
            desc = 'Format Document',
        },
    },
}

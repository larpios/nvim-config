require('nvim-treesitter.configs').setup({
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['am'] = '@function.outer',
                ['im'] = '@function.inner',
                ['ac'] = '@class.outer',
                ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
                ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
                ['aL'] = { query = '@loop.outer', desc = 'Select outer part of a loop region' },
                ['iL'] = { query = '@loop.inner', desc = 'Select inner part of a loop region' },
            },
            selection_modes = {
                ['@parameter.outer'] = 'v',
                ['@function.outer'] = 'V',
                ['@class.outer'] = '<c-v>',
            },
            include_surrounding_whitespace = true,
        },
        swap = {
            enable = true,
            swap_next = { ['<leader>a'] = '@parameter.inner' },
            swap_previous = { ['<leader>A'] = '@parameter.inner' },
        },
        move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
                [']m'] = '@function.outer',
                [']]'] = { query = '@class.outer', desc = 'Next class start' },
                [']l'] = '@loop.*',
                [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
                [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
            },
            goto_next_end = {
                [']M'] = '@function.outer',
                [']['] = '@class.outer',
            },
            goto_previous_start = {
                ['[m'] = '@function.outer',
                ['[['] = '@class.outer',
            },
            goto_previous_end = {
                ['[M'] = '@function.outer',
                ['[]'] = '@class.outer',
            },
            goto_next = { [']f'] = '@conditional.outer' },
            goto_previous = { ['[f'] = '@conditional.outer' },
        },
        lsp_interop = {
            enable = true,
            border = 'rounded',
            floating_preview_opts = {},
            peek_definition_code = {
                ['<leader>df'] = '@function.outer',
                ['<leader>dF'] = '@class.outer',
            },
        },
    },
    sync_install = false,
    auto_install = true,
    ensure_installed = { 'markdown', 'markdown_inline', 'html', 'c', 'cpp', 'lua', 'luadoc' },
    highlight = { enable = true },
})

local opts = {
    -- available commands:
    --   show, hide, accept, select_and_accept, select_prev, select_next, show_documentation, hide_documentation,
    --   scroll_documentation_up, scroll_documentation_down, snippet_forward, snippet_backward, fallback
    keymap = {
        ['<C-e>'] = { 'hide' },
        ['<C-y>'] = { 'accept' },
        ['<C-Space>'] = { 'show_documentation', 'hide_documentation' },
        ['<C-f>'] = { 'snippet_forward', 'scroll_documentation_down', 'fallback' },
        ['<C-b>'] = { 'snippet_backward', 'scroll_documentation_up', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'show', 'select_next', 'fallback' },
    },
    trigger = {
        completion = {
            show_in_snippet = true,
        },
        -- signature_help = {
        --     enabled = true,
        -- },
    },
    highlight = {
        ns = vim.api.nvim_create_namespace('blink_cmp'),
        -- sets the fallback highlight groups to nvim-cmp's highlight groups
        -- useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release, assuming themes add support
        use_nvim_cmp_as_default = true,
    },
    sources = {
        completions = { 'lsp', 'path', 'snippets', 'buffer' },
        providers = {
            lsp = { 'blink.cmp.sources.lsp', name = 'LSP', score_offset = 100 },
            path = { 'blink.cmp.sources.path', name = 'Path', score_offset = 3 },
            snippets = {
                'blink.cmp.sources.snippets',
                name = 'Snippets',
                score_offset = -3,
                opts = {
                    friendly_snippets = true,
                    search_paths = {
                        vim.fn.stdpath('config') .. '/snippets',
                    },
                },
            },
            buffer = { 'blink.cmp.sources.buffer', name = 'Buffer', fallback_for = { 'LSP' }, score_offset = -100 },
        },
    },
    windows = {

        autocomplete = {
            border = 'rounded',
            ---@param ctx blink.cmp.CompletionRenderContext
            draw = function(ctx)
                return {
                    ' ',
                    { ctx.kind_icon, ctx.icon_gap, hl_group = 'BlinkCmpKind' .. ctx.kind },

                    ' ',
                    { ctx.label, ctx.kind == 'Snippet' and '~' or nil, fill = true, hl_group = 'BlinkCmpItem' },
                    ' ',
                    { '[' .. ctx.item.source_name .. ']', hl_group = 'BlinkCmpSource' },
                }
            end,
        },
        documentation = {
            min_width = 30,
            max_width = 80,
            max_height = 40,
            border = 'rounded',
            auto_show = true,
        },
    },
    -- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'normal',

    -- experimental auto-brackets support
    accept = { auto_brackets = { enabled = true } },

    -- experimental signature help support
}

require('blink.cmp').setup(opts)

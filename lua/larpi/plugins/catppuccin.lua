return {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
        flavour = 'auto', -- latte, frappe, macchiato, mocha
        transparent_background = vim.g.transparent_enabled, -- from transparent.nvim
        float = {
            transparent = vim.g.transparent_enabled,
        },
        show_end_of_buffer = true,
        dim_inactive = {
            enabled = true,
            shade = 'dark',
            percentage = 0.1,
        },
        integrations = {
            blink_cmp = true,
            colorful_winsep = {
                enabled = true,
                color = 'red',
            },
            diffview = true,
            dropbar = {
                enabled = true,
                color_mode = true,
            },
            fzf = true,
            cmp = true,
            gitsigns = true,
            grug_far = true,
            indent_blankline = {
                enabled = true,
                scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
                colored_indent_levels = false,
            },
            markdown = true,
            mason = true,
            nvimtree = true,
            neogit = true,
            noice = true,
            treesitter = true,
            overseer = true,
            rainbow_delimiters = true,
            render_markdown = true,
            snacks = {
                enabled = true,
                indent_scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
            },
            lsp_trouble = true,
            which_key = true,
            notify = true,
            mini = {
                enabled = true,
                indentscope_color = '',
            },
            dashboard = true,
        },
    },
}

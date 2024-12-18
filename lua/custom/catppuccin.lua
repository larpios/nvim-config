local opts = {
    -- transparent_background = true,
    styles = {
        sidebars = 'transparent',
        floats = 'transparent',
    },
    default_integrations = true,
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = {
            enabled = true,
            indentscope_color = '',
        },
        dashboard = true,
    },
}

require('catppuccin').setup(opts)

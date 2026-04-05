return {
    -- Image preview hover
    'hmdfrds/focal.nvim',
    event = 'VeryLazy',
    dependencies = {
        '3rd/image.nvim', -- optional if using chafa backend
    },
    cmds = {
        'FocalEnable',
        'FocalStatus',
        'FocalShow',
        'FocalHide',
        'FocalDisable',
        'FocalToggle',
    },
    opts = {
        enabled = false,
        border = vim.g.winborder,
        debounce_ms = 100,
    },
}

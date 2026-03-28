return {
    'smjonas/live-command.nvim',
    cmd = { 'Norm', 'Preview' },
    opts = {
        enable_highlighting = true,
        inline_highlighting = true,
        commands = {
            Norm = { cmd = 'norm' },
        },
    },
}

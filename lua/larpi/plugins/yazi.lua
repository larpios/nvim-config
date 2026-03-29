return {
    'mikavilpas/yazi.nvim',
    version = '*',
    event = 'VeryLazy',
    dependencies = {
        { 'nvim-lua/plenary.nvim', lazy = true },
    },
    keys = {
        {
            '<leader>-',
            '<cmd>Yazi<cr>',
            mode = { 'n', 'x' },
            desc = '[Yazi] Open yazi at the current file',
        },
        {
            '<leader>ty',
            '<cmd>Yazi<cr>',
            mode = { 'n', 'x' },
            desc = '[Yazi] Open yazi at the current file',
        },
        {
            -- Open in the current working directory
            '<leader>tY',
            '<cmd>Yazi cwd<cr>',
            desc = "[Yazi] Open the file manager in nvim's working directory",
        },
    },
    ---@type YaziConfig | {}
    opts = {
        -- enable it if you want to open yazi instead of netrw, see below for more info
        open_for_directories = false,
        keymaps = {
            show_help = '?',
        },
    },
}

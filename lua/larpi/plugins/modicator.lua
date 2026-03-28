return {
    -- Changes the color of the line number depending on the current mode.
    'mawkler/modicator.nvim',
    event = 'VeryLazy',
    init = function()
        -- These are required for Modicator to work
        vim.o.cursorline = true
        vim.o.number = true
        vim.o.termguicolors = true
    end,
    opts = {},
}

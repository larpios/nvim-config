local opts = {
    maxkeys = 3,
    winopts = {
        focusable = true,
    },
    -- show_count = true,
    position = 'top-right',
}

require('showkeys').setup(opts)

vim.cmd([[
    ShowkeysToggle
]])

local opts = {
    maxkeys = 5,
    winopts = {
        focusable = true,
    },
    position = 'top-right',
}

require('showkeys').setup(opts)

vim.cmd([[
    ShowkeysToggle
]])

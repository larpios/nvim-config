local copilot = require('copilot')

local options = {
    suggestion = { enabled = false },
    panel = { enabled = false }
}

copilot.setup(options)

vim.keymap.set('i', '<C-A>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
})
vim.g.copilot_no_tab_map = true


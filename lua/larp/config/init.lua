require('larp.config.opts')
require('larp.config.keymaps')

vim.schedule(function()
    require('larp.config.autocmds')
    require('larp.config.lsp')
end)

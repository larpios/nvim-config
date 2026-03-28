require('larpi.config.opts')
require('larpi.config.keymaps')

vim.schedule(function()
    require('larpi.config.autocmds')
    require('larpi.config.lsp')
end)

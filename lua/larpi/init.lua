require('larpi.config')
require('larpi.lazy')

-- Defer third-party and heavier configs to keep initial startup fast
vim.schedule(function()
    require('larpi.third-party')
end)

vim.cmd.colorscheme('catppuccin-mocha')

require('larp.config')
require('larp.lazy')

-- Defer third-party and heavier configs to keep initial startup fast
vim.schedule(function()
    require('larp.third-party')
end)

vim.cmd.colorscheme('catppuccin-mocha')

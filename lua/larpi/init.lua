_G.larpi = {
    fn = require('larpi.utils.fn'),
}

require('larpi.config')

if not vim.env.NO_PLUGINS then
    require('larpi.lazy')
end

-- Defer third-party and heavier configs to keep initial startup fast
vim.schedule(function()
    require('larpi.third-party')
end)

vim.cmd.colorscheme('catppuccin')

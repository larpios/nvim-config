if vim.loader then
    vim.loader.enable()
end

if vim.fn.has('nvim-0.12') == 1 then
    require('vim._core.ui2').enable()
end

require('larpi')

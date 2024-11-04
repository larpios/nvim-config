require('smart-splits').setup({
    resize_mode = {
        hooks = {
            on_enter = function()
                vim.notify('Entering resize mode')
            end,
            on_leave = function()
                vim.notify('Exiting resize mode')
            end,
        },
    },
})

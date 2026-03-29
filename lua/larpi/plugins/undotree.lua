return {
    'jiaoshijie/undotree',
    ---@module 'undotree.collector'
    ---@type UndoTreeCollector.Opts
    opts = {},
    keys = { -- load the plugin only when using it's keybinding:
        {
            '<leader>tu',
            function()
                require('undotree').toggle()
            end,
            desc = '[UndoTree] Toggle',
        },
    },
}

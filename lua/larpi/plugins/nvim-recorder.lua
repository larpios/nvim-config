return {
    -- Enhance the usage of macros in Neovim
    'chrisgrieser/nvim-recorder',
    event = 'VeryLazy',
    opts = {
        mapping = {
            startStopRecording = '<leader>q',
            playMacro = '<leader>Q',
            switchSlot = '<leader>mn',
            editMacro = '<leader>me',
            deleteAllMacros = '<leader>md',
            yankMacro = '<leader>my',
            -- ⚠️ this should be a string you don't use in insert mode during a macro
            addBreakPoint = '##',
        },
    }, -- required even with default settings, since it calls `setup()`
}

return {
    -- Sudo write/read
    'lambdalisue/vim-suda',
    keys = {
        { '<leader>Sw', '<cmd>SudaWrite<cr>', mode = 'n', desc = '[Suda] Sudo Write' },
        { '<leader>Sr', '<cmd>SudaRead<cr>', mode = 'n', desc = '[Suda] Sudo Read' },
    },
    cmd = { 'SudaWrite', 'SudaRead' },
    init = function()
        vim.g.suda_smart_edit = 1
    end,
}

return {
    'NicholasZolton/neojj',
    opts = {
        disable_line_numbers = false,
        user_per_project_settings = false,
        integrations = {
            codediff = true,
            snacks = true,
        },
    },
    cmd = 'Neojj',
    keys = {
        {
            '<leader>jj',
            function()
                require('neojj').open()
            end,
            desc = '[Neojj] Show Neojj UI',
        },
        {
            '<leader>jc',
            function()
                require('neojj').open({ cwd = vim.fn.stdpath('config') })
            end,
            desc = '[Neojj] Run Neojj in Neovim Config',
        },
    },
    dependencies = {
        'nvim-lua/plenary.nvim', -- required
        'esmuellert/codediff.nvim',
        'folke/snacks.nvim',
    },
}

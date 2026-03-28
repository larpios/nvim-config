return {
    -- TODO: Switch back to the upstream when the PR is merged
    -- 'NicholasZolton/neojj',
    'larpios/neojj',
    branch = 'fix/workspace-root-resolution',
    lazy = true,
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
                -- TODO: Remove this hack when the PR is merged
                -- HACK: Currently, without `_workspace_root` set, Neojj will refuse to open in the config directory, saying it's not a workspace.
                -- `_workspace_root` is set [here](https://github.com/NicholasZolton/neojj/blob/fdb6b50a4c5d52849c0b1eb0d493ea6feb634f48/lua/neojj.lua#L81-L90),
                -- and used [here](https://github.com/NicholasZolton/neojj/blob/fdb6b50a4c5d52849c0b1eb0d493ea6feb634f48/lua/neojj.lua#L136-L162)
                -- local config_dir = vim.fn.stdpath('config')
                -- require('neojj').open({ cwd = config_dir, _workspace_root = config_dir})

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

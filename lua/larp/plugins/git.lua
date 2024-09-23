return {
    {
        'kdheepak/lazygit.nvim',
        enabled = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
        },
        keys = {
            { '<leader>cg', '<cmd>LazyGit<cr>', noremap = true, silent = true, desc = 'LazyGit' },
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                on_attach = function(bufnr)
                    local gitsigns = require('gitsigns')

                    local function map(mode, l, r, opts)
                        opts = opts or {}
                        opts.buffer = bufnr
                        larp.fn.map(mode, l, r, opts)
                    end

                    -- Navigation
                    map('n', ']c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ ']c', bang = true })
                        else
                            gitsigns.nav_hunk('next')
                        end
                    end, { desc = 'Go to Next Hunk' })

                    map('n', '[c', function()
                        if vim.wo.diff then
                            vim.cmd.normal({ '[c', bang = true })
                        else
                            gitsigns.nav_hunk('prev')
                        end
                    end, { desc = 'Go to Previous Hunk' })

                    -- Actions
                    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'Stage Hunk' })
                    map('n', '<leader>hr', gitsigns.reset_hunk)
                    map('v', '<leader>hs', function()
                        gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end, { desc = 'Stage Hunk' })
                    map('v', '<leader>hr', function()
                        gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                    end)
                    map('n', '<leader>hS', gitsigns.stage_buffer)
                    map('n', '<leader>hu', gitsigns.undo_stage_hunk)
                    map('n', '<leader>hR', gitsigns.reset_buffer)
                    map('n', '<leader>hp', gitsigns.preview_hunk)
                    map('n', '<leader>hb', function()
                        gitsigns.blame_line({ full = true })
                    end)
                    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                    map('n', '<leader>hd', gitsigns.diffthis)
                    map('n', '<leader>hD', function()
                        gitsigns.diffthis('~')
                    end)
                    map('n', '<leader>td', gitsigns.toggle_deleted)

                    -- Text object
                    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
                end,
            })
        end,
    },
    {
        'sindrets/diffview.nvim',
    },
    {
        'NeogitOrg/neogit',
        dependencies = {
            'nvim-lua/plenary.nvim', -- required
            'sindrets/diffview.nvim', -- optional - Diff integration

            'ibhagwan/fzf-lua', -- optional
        },
        config = function()
            require('neogit').setup({})
            larp.fn.map('n', '<leader>Gno', '<cmd>Neogit<cr>', { desc = 'Open Neogit' })
            larp.fn.map('n', '<leader>Gnd', '<cmd>Neogit diff <cr>', { desc = 'Open Neogit Diff' })
        end,
    },
    {
        'tpope/vim-fugitive',
        enabled = false,
    },
}

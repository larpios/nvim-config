return {

    {
        'stevearc/overseer.nvim',
        opts = {},
        config = function()
            local overseer = require('overseer')
            overseer.setup({
                templates = {
                    'builtin',
                    -- 'user.cpp_build',
                },
            })
            overseer.register_template('user.cpp_build', {
                name = 'C++ cmake build',
                cmd = { 'cmake ..', 'make' },
                condition = {
                    filetype = 'cpp',
                    callback = function()
                        return vim.fn.filereadable('CMakeLists.txt') == 1
                    end,
                },
            })
            larp.fn.map('n', '<leader>Ot', ':OverseerToggle<CR>', { desc = 'Toggle Overseer' })
            larp.fn.map('n', '<leader>Or', ':OverseerRun<CR>', { desc = 'Overseer Run' })
            larp.fn.map('n', '<leader>Ob', ':OverseerBuild<CR>', { desc = 'Overseer Build' })
            larp.fn.map('n', '<leader>OR', ':OverseerRunCmd<CR>', { desc = 'Overseer Run Cmd' })
        end,
    },
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            {
                'rcarriga/nvim-dap-ui',
                dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
            },
            {
                'nvim-treesitter/nvim-treesitter',
                build = ':TSUpdate',
            },
            'theHamsta/nvim-dap-virtual-text',
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            require('nvim-dap-virtual-text').setup()
            dapui.setup({})
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.open()
            end

            dap.adapters.gdb = {
                type = 'executable',
                command = '/usr/bin/gdb',
                name = 'gdb',
            }
            dap.adapters.lldb = {
                type = 'executable',
                command = '/usr/bin/lldb-dap',
                name = 'lldb',
            }
            dap.configurations.cpp = {
                {
                    name = 'Launch',
                    type = 'lldb',
                    request = 'launch',
                    program = function()
                        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
                    end,
                    cwd = '${workspaceFolder}',
                    stopOnEntry = true,
                    args = function()
                        return vim.fn.input('Arguments: ', '', 'file')
                    end,
                    runInTerminal = false,
                },
            }
            dap.configurations.c = dap.configurations.cpp
            dap.configurations.rust = dap.configurations.cpp

            larp.fn.map('n', '<leader>cdb', dap.toggle_breakpoint, { desc = 'Toggle breakpoint', desc_prefix = 'DAP' })
            larp.fn.map('n', '<leader>cdr', dap.run, { desc = 'Continue', desc_prefix = 'DAP' })
            larp.fn.map('n', '<leader>cdc', dap.continue, { desc = 'Continue', desc_prefix = 'DAP' })
            larp.fn.map('n', '<F3>', dap.step_over, { desc = 'Step Over', desc_prefix = 'DAP' })
            larp.fn.map('n', '<F4>', dap.step_into, { desc = 'Step Into', desc_prefix = 'DAP' })
        end,
    },
    {
        -- 1. Highlights TODO, FIXME, etc. in your code
        -- 2. Provides a list of all the highlights in your project
        'folke/todo-comments.nvim',
        event = 'BufRead',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {

            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
        config = function()
            require('todo-comments').setup({})
            larp.fn.map('n', ']t', function()
                require('todo-comments').jump_next()
            end, { desc = 'Next todo comment' })
            larp.fn.map('n', '[t', function()
                require('todo-comments').jump_prev()
            end, { desc = 'Previous todo comment' })
            -- You can also specify a list of valid jump keywords
            larp.fn.map('n', ']t', function()
                require('todo-comments').jump_next({ keywords = { 'ERROR', 'WARNING' } })
            end, { desc = 'Next error/warning todo comment' })
        end,
    },
    {
        'luckasRanarison/nvim-devdocs',
        enabled = false,
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope.nvim',
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {},
    },
    {
        'michaelb/sniprun',
        build = 'sh ./install.sh 1',
    },
    {
        'chipsenkbeil/distant.nvim',
        branch = 'v0.3',
        config = function()
            require('distant'):setup()
        end,
    },
}

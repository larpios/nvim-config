return {
    'nvim-lualine/lualine.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require('lualine').setup({
            options = {
                theme = 'auto',
            },
            sections = {
                lualine_a = { 'mode' },
                lualine_b = { 'branch', 'diff', 'diagnostics' },
                lualine_c = {
                    'filename',
                    {
                        function()
                            return vim.bo.modified and '' or ''
                        end,
                    },
                    {
                        function()
                            return vim.bo.readonly and '' or ''
                        end,
                    },
                    {
                        function()
                            return vim.bo.buftype == 'quickfix' and '' or ''
                        end,
                    },
                },
                lualine_x = {
                    {
                        --- Lsp server name
                        function()
                            local msg = 'No Active Lsp'
                            local buf_ft = vim.api.nvim_get_option_value('filetype', { buf = 0 })
                            local clients = vim.lsp.get_clients()
                            if next(clients) == nil then
                                return msg
                            end
                            for _, client in ipairs(clients) do
                                local filetypes = client.config.filetypes
                                if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                                    return client.name
                                end
                            end
                            return msg
                        end,
                    },
                    'encoding',
                    'fileformat',
                    'filetype',
                },
                lualine_y = { 'progress' },
                lualine_z = { 'location' },
            },
        })
    end,
}

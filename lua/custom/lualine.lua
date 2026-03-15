local overseer = require('overseer')
local recorder = require('recorder') -- nvim-recorder 

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
                'overseer',
                label = '',     -- Prefix for task counts
                colored = true, -- Color the task icons and counts
                symbols = {
                    [overseer.STATUS.FAILURE] = 'F:',
                    [overseer.STATUS.CANCELED] = 'C:',
                    [overseer.STATUS.SUCCESS] = 'S:',
                    [overseer.STATUS.RUNNING] = 'R:',
                },
                unique = false,     -- Unique-ify non-running task count by name
                name = nil,         -- List of task names to search for
                name_not = false,   -- When true, invert the name search
                status = nil,       -- List of task statuses to display
                status_not = false, -- When true, invert the status search
            },
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
        lualine_y = { 'progress', recorder.displaySlots },
        lualine_z = { 'location', recorder.recordingStatus },
    },
})

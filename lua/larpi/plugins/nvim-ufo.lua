return {
    -- Better folding
    'kevinhwang91/nvim-ufo',
    event = 'BufRead',
    dependencies = { 'kevinhwang91/promise-async' },
    keys = {
        {
            'zR',
            function()
                require('ufo').openAllFolds()
            end,
            desc = 'Open all folds',
        },
        {
            'zM',
            function()
                require('ufo').closeAllFolds()
            end,
            desc = 'Close all folds',
        },
        {
            'zuc',
            function()
                local level = vim.fn.input('Enter fold level: ')
                level = tonumber(level)
                require('ufo').closeFoldsWith(level)
            end,
            desc = 'Close folds with level',
        },
        {
            'z;',
            function()
                require('ufo.action').goNextClosedFold()
            end,
            desc = 'Go to next closed fold',
        },
        {
            'z,',
            function()
                require('ufo.action').goPreviousClosedFold()
            end,
            desc = 'Go to previous closed fold',
        },
    },
    init = function()
        vim.o.foldcolumn = '1'
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true
    end,
    config = function()
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true,
        }
        local language_servers = require('lspconfig').util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
        for _, ls in ipairs(language_servers) do
            require('lspconfig')[ls].setup({
                capabilities = capabilities,
                -- you can add other fields for setting up lsp server in this table
            })
        end
        local handler = function(virtText, lnum, endLnum, width, truncate)
            local newVirtText = {}
            local suffix = (' 󰁂 %d '):format(endLnum - lnum)
            local sufWidth = vim.fn.strdisplaywidth(suffix)
            local targetWidth = width - sufWidth
            local curWidth = 0
            for _, chunk in ipairs(virtText) do
                local chunkText = chunk[1]
                local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                if targetWidth > curWidth + chunkWidth then
                    table.insert(newVirtText, chunk)
                else
                    chunkText = truncate(chunkText, targetWidth - curWidth)
                    local hlGroup = chunk[2]
                    table.insert(newVirtText, { chunkText, hlGroup })
                    chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    -- str width returned from truncate() may less than 2nd argument, need padding
                    if curWidth + chunkWidth < targetWidth then
                        suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                    end
                    break
                end
                curWidth = curWidth + chunkWidth
            end
            table.insert(newVirtText, { suffix, 'MoreMsg' })
            return newVirtText
        end

        require('ufo').setup({
            fold_virt_text_handler = handler,
        })
    end,
}

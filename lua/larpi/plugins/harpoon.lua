return {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'folke/snacks.nvim',
            optional = true,
        },
    },
    keys = {
        {
            '<leader>Ha',
            function()
                require('harpoon'):list():add()
                vim.notify(string.format('Added `%s` to Harpoon', vim.fn.expand('%:p')))
            end,
            desc = '[Harpoon] Add',
        },
        {
            '<leader>He',
            function()
                local use_default = false
                local harpoon = require('harpoon')

                if use_default then
                    harpoon.ui:toggle_quick_menu(harpoon:list())
                    return
                end
                local function ctm_pick(harpoon_files)
                    if package.loaded['snacks.picker'] then
                        if harpoon_files:length() == 0 then
                            vim.notify('No harpoon files', vim.log.levels.WARN)
                            return
                        end

                        local items = {}
                        for i = 1, harpoon_files._length do
                            local item = harpoon_files.items[i]

                            if items ~= nil then
                                local row = item.context.row or 1
                                local col = item.context.col or 0

                                table.insert(items, {
                                    text = item.value,
                                    file = item.value,
                                    pos = { row, col },
                                    idx = i,
                                    harpoon_item = item,
                                })
                            end
                        end

                        Snacks.picker({
                            title = 'Harpoon',
                            items = items,
                            format = 'file',
                            actions = {
                                remove_item = function(picker, item)
                                    local selected_items = picker:selected()

                                    if #selected_items == 0 and item then
                                        selected_items = { item }
                                    end

                                    if #selected_items == 0 then
                                        return
                                    end

                                    for _, sel in ipairs(selected_items) do
                                        harpoon:list():remove(sel.harpoon_item)
                                        vim.notify('Removed ' .. sel.file .. ' from the Harpoon list.', vim.log.levels.INFO)
                                    end

                                    picker:close()
                                end,
                            },
                            win = {
                                input = {
                                    keys = {
                                        ['<C-d>'] = { 'remove_item', mode = { 'n', 'i' } },
                                    },
                                },
                            },
                        })
                    else
                        harpoon.ui:toggle_quick_menu(harpoon_files)
                    end
                end

                ctm_pick(harpoon:list())
            end,
            desc = '[Harpoon] Open Menu',
        },
        {
            '<leader>H1',
            function()
                require('harpoon'):list():select(1)
            end,
            desc = '[Harpoon] Harpoon Mark 1',
        },
        {
            '<leader>H2',
            function()
                require('harpoon'):list():select(2)
            end,
            desc = '[Harpoon] Harpoon Mark 2',
        },
        {
            '<leader>H3',
            function()
                require('harpoon'):list():select(3)
            end,
            desc = '[Harpoon] Harpoon Mark 3',
        },
        {
            '<leader>H4',
            function()
                require('harpoon'):list():select(4)
            end,
            desc = '[Harpoon] Harpoon Mark 4',
        },
        {
            '<leader>Hp',
            function()
                require('harpoon'):list():prev()
            end,
            desc = '[Harpoon] Previous',
        },
        {
            '<leader>Hp',
            function()
                require('harpoon'):list():next()
            end,
            desc = '[Harpoon] Next',
        },
    },
    opts = {},
}

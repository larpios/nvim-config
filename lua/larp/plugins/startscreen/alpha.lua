local arts = require('larp.plugins.startscreen.arts')
local random_art = larp.fn.tbl_choose_random(arts)[1]

---@param art_lines string[]
---@param max_width integer
---@param max_height integer
---@return string[]
local function limit_size(art_lines, max_width, max_height)
    local new_lines = art_lines
    local exceeding_rows = #new_lines - max_height
    if exceeding_rows > 0 then
        -- Tries to cut the top and bottom lines evenly
        -- The topmost lines gets to deleted one line less than the bottommost ones if `exceeding_lines` is an odd number
        local start_skip_cnt = math.floor(exceeding_rows / 2)
        local end_skip_cnt = exceeding_rows - start_skip_cnt

        -- Removes exceeding rows
        local skip_row_indices = larp.fn.create_sequence(start_skip_cnt)
        larp.fn.tbl_append(skip_row_indices, larp.fn.create_sequence(#new_lines - end_skip_cnt + 1, #new_lines))
        for _, idx in ipairs(skip_row_indices) do
            table.remove(new_lines, idx)
        end
    end
    for i, line in ipairs(new_lines) do
        local num_cols = string.len(line)
        if num_cols > max_width then
            local exceeding_cols = num_cols - max_width
            local start_col = exceeding_cols / 2
            local end_col = (num_cols - (exceeding_cols - start_col))
            new_lines[i] = string.sub(line, start_col + 1, end_col + 1)
        end
    end
    return new_lines
end

return {
    'goolord/alpha-nvim',
    dependencies = 'kyazdani42/nvim-web-devicons',
    config = function()
        local alpha = require('alpha')
        local theme = require('alpha.themes.startify')
        -- local theme = require('alpha.themes.dashboard')
        -- theme.section.header.val = random_art.art
        theme.section.header.val = limit_size(random_art.art, 50, 50)
        alpha.setup(theme.config)
    end,
}

local arts = require('larp.plugins.startscreen.arts')
local random_art = larp.fn.tbl_choose_random(arts)[1]

--- Limits the size of ASCII art by trimming the number of lines and the width of each line.
--- Preserves the central part of each line to maintain visual integrity.
---@param art_lines string[]
---@param max_width integer
---@param max_height integer
---@return string[]
local function limit_size(art_lines, max_width, max_height)
    -- Validate input parameters
    assert(type(art_lines) == 'table', 'art_lines must be a table of strings')
    assert(type(max_width) == 'number' and max_width > 0, 'max_width must be a positive number')
    assert(type(max_height) == 'number' and max_height > 0, 'max_height must be a positive number')

    -- Create a shallow copy of art_lines to avoid mutating the original table
    -- local new_lines = {}
    -- for _, line in ipairs(art_lines) do
    --     table.insert(new_lines, line)
    -- end
    local new_lines = vim.fn.copy(art_lines)

    local current_height = #new_lines

    -- Trim height if necessary
    if current_height > max_height then
        local excess_rows = current_height - max_height
        local half_excess = math.floor(excess_rows / 2)
        local start_trim = half_excess
        local end_trim = excess_rows - half_excess

        local start_idx = start_trim + 1
        local end_idx = current_height - end_trim

        new_lines = vim.list_slice(new_lines, start_idx, end_idx)
    end

    -- Trim width for each line if necessary
    for i, line in ipairs(new_lines) do
        -- Calculate the number of UTF-8 characters
        local line_length = larp.fn.utf8_len(line)
        if line_length > max_width then
            local excess_cols = line_length - max_width
            local half_excess = math.floor(excess_cols / 2)
            local start_col = half_excess + 1
            local end_col = start_col + max_width - 1

            new_lines[i] = larp.fn.utf8_sub(line, start_col, end_col)
        end
    end

    return new_lines
end

return {
    'goolord/alpha-nvim',
    dependencies = {
        'kyazdani42/nvim-web-devicons',
        'folke/persistence.nvim',
    },
    config = function()
        local alpha = require('alpha')
        -- local theme = require('alpha.themes.startify')
        local theme = require('alpha.themes.dashboard')
        local persistence = require('persistence')
        -- theme.section.header.val = random_art.art
        theme.section.header.val = limit_size(random_art.art, 80, 20)
        theme.section.buttons.val = {
            theme.button('e', '  New file', ':enew<CR>'),
            theme.button('n', '  Load session', ':lua require("persistence").load()<CR>'),
            theme.button('q', '  Quit', ':qa<CR>'),
        }
        alpha.setup(theme.config)
    end,
}

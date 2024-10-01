local M = {}

---My special Module :)
---@class larp
---@field fn larp.fn
M = M or {}

---@class larp.fn
-- ---@field merge_dict function
-- ---@field map function
-- ---@field multimap function
M.fn = M.fn or {}
M.fn.merge_dict = M.fn.merge_dict or {}
M.fn.map = M.fn.map or vim.keymap.set
M.fn.multimap = M.fn.multimap or {}

---@class larp.fn.merge_dict.opts
---@field overlay? larp.fn.merge_dict.opts.overlay
---@field format? fun(key: any, value: any): any function to format values in `overlay` table.
---
---@class larp.fn.merge_dict.opts.overlay
---@field enable? boolean Whether to overlay.
---@field exclude? table Array of specific keys to prevent correspoding values from getting overlayed.
---
---Merge two tables, one overlaying the other.
---@param base table Base table to be overlayed.
---@param top table Overlay table to be overlayed with onto {base}.
---@param opts? larp.fn.merge_dict.opts Options
---@return table
function M.fn.merge_dict(base, top, opts)
    opts = opts or {}
    setmetatable(opts, {
        __index = {
            overlay = {
                enable = true,
                exclude = {},
            },
            format = function(_, v)
                return v
            end,
        },
    })

    for k, v in pairs(top) do
        if (opts.overlay == false and opts[k] ~= nil) or opts.overlay == true then
            base[k] = opts.format(v)
        end
    end
    return base
end

---@class larp.fn.map.Params
---@field mode string Mode in which the keymap is applied.
---@field lhs string Key sequence to be mapped.
---@field rhs string|function Key sequence or function to be simulated.
---@field opts? larp.fn.map.Opts

---@class larp.fn.map.Opts : vim.keymap.set.Opts
---@field desc_prefix? string String prefix to add to description.

---Set keymaps. Same with [vim.keymap.set()](lua://vim.api.nvim_set_keymap), but with some tweaks.
---@param mode string|table Mode in which the keymap is applied.
---@param lhs string Key sequence to be mapped.
---@param rhs string|function Key sequence or function to be simulated.
---@param opts? larp.fn.map.Opts Options to change behavior of the keymap function.
---@see larp.fn.multimap
---@return nil
function M.fn.map(mode, lhs, rhs, opts)
    opts = opts or {}
    setmetatable(opts, {
        __index = {
            silent = true,
            remap = false,
            desc_prefix = '[larp] ',
        },
    })

    opts.desc = opts.desc ~= nil and opts.desc_prefix .. opts.desc or opts.desc
    opts.desc_prefix = nil
    vim.keymap.set(mode, lhs, rhs, opts)
end

---Set Keymaps at once using [map](lua://larp.fn.map) function.
---@param keymaps larp.fn.map.Params[] List of keymaps.
---@see larp.fn.map
---@return nil
function M.fn.multimap(keymaps)
    for _, keymap in ipairs(keymaps) do
        M.fn.map(table.unpack(keymap))
    end
end

---Returns {true_val} if {cond} is true, otherwise {false_val}.
---@param cond boolean|fun(...):boolean
---@param true_val any
---@param false_val any
---@return any
function M.fn.get_if_or(cond, true_val, false_val)
    if type(cond) == 'function' then
        cond = cond()
    end
    if cond then
        return true_val
    else
        return false_val
    end
end

---Return a new sliced table with elements at indices from {start_idx} to {end_idx}.
---@param tbl table
---@param start_idx integer
---@param end_idx integer Last index up to at which elements to slice. Its exclusivity depends on {is_end_exclusive}.
---@param is_end_exclusive? boolean Whether to exclude the elemnt at {end_idx}. Its value is `false` by default.
---@return table
function M.fn.tbl_slice(tbl, start_idx, end_idx, is_end_exclusive)
    tbl = tbl or {}
    start_idx = start_idx or 1
    end_idx = end_idx or 1
    is_end_exclusive = is_end_exclusive or false

    if start_idx > end_idx then
        error(string.format("Start index can't be greater than end index: (%d, %d)", start_idx, end_idx), 2)
    end
    if start_idx < 1 then
        error(string.format("Start index can't be less than 1: (%d)", start_idx), 2)
    end

    local new_tbl = {}
    local idx = start_idx
    while idx < end_idx + larp.fn.get_if_or(is_end_exclusive, 0, 1) do
        table.insert(new_tbl, idx - start_idx + 1, tbl[idx])
        idx = idx + 1
    end
    return new_tbl
end

---Append a table to anthoter
---@param t1 table
---@param t2 table
---@return table
function M.fn.tbl_append(t1, t2)
    for _, val in ipairs(t2) do
        table.insert(t1, val)
    end
    return t1
end

---Get values of a table by the key.
---Returns a table of values
---@param tbls table[]
---@param key string|integer
---@param formatter? fun(value):any
---@return table
function M.fn.tbl_get_by_key(tbls, key, formatter)
    formatter = formatter or function(v)
        return v
    end
    local values = {}

    for _, tbl in ipairs(tbls) do
        for k, v in pairs(tbl) do
            if k == key then
                table.insert(values, formatter(v))
            end
        end
    end
    return values
end

---Returns selection range
---@return table
function M.fn.get_selection_range()
    local pos1 = larp.fn.tbl_slice(vim.fn.getpos('v'), 2, 3)
    local pos2 = larp.fn.tbl_slice(vim.fn.getpos('.'), 2, 3)
    local start_tbl, end_tbl
    if pos1[1] < pos2[1] or (pos1[1] == pos2[1] and pos1[2] <= pos2[2]) then
        start_tbl = pos1
        end_tbl = pos2
    else
        start_tbl = pos2
        end_tbl = pos1
    end
    if vim.fn.mode() == 'V' then
        start_tbl[2] = 1
    end
    local tbl = larp.fn.tbl_append(start_tbl, end_tbl)

    return tbl
end

---Get currently selected text.
---@return table
function M.fn.get_selection_text()
    local srow, scol = unpack(vim.fn.getpos('v'), 2, 3)
    local erow, ecol = unpack(vim.fn.getpos('.'), 2, 3)

    -- visual line mode
    if vim.fn.mode() == 'V' then
        if srow > erow then
            return vim.api.nvim_buf_get_lines(0, erow - 1, srow, true)
        else
            return vim.api.nvim_buf_get_lines(0, srow - 1, erow, true)
        end
    end

    -- regular visual mode
    if vim.fn.mode() == 'v' then
        if srow < erow or (srow == erow and scol <= ecol) then
            return vim.api.nvim_buf_get_text(0, srow - 1, scol - 1, erow - 1, ecol, {})
        else
            return vim.api.nvim_buf_get_text(0, erow - 1, ecol - 1, srow - 1, scol, {})
        end
    end

    -- visual block mode
    if vim.fn.mode() == '\22' then
        local lines = {}
        if srow > erow then
            srow, erow = erow, srow
        end
        if scol > ecol then
            scol, ecol = ecol, scol
        end
        for i = srow, erow do
            table.insert(lines, vim.api.nvim_buf_get_text(0, i - 1, math.min(scol - 1, ecol), i - 1, math.max(scol - 1, ecol), {})[1])
        end
        return lines
    end
    return { '' }
end

-- ---Surround selection with {sym}. It should be togglable, meaning the selection should stay the same with the {sym} characters, allowing for you to call the function again to remove them.
-- ---@param sym string
-- function M.fn.toggle_marker(sym)
--     local mode = vim.fn.mode()
--     local lines = larp.fn.get_selection_text()
--     local buff = table.concat(lines)
--     buff = vim.trim(buff)
--     local cfirst = string.sub(buff, 1, 1)
--     local clast = string.sub(buff, #buff)
--     local txt
--     local start_row, start_col, end_row, end_col = unpack(larp.fn.get_selection_range())
--     if cfirst ~= sym or clast ~= sym then
--         txt = string.format('c%s%s<esc>P%dG%d|v%dG%d|', sym, sym, start_row, start_col, end_row, end_col + 2)
--     else
--         txt = string.format('xPx%dG%d|xv%dG%d|', start_row, start_col, end_row, end_col - 2)
--     end
--     vim.cmd('norm ' .. txt)
-- end

-- Function to toggle markers around a selection (supports multi-line)
function M.fn.toggle_marker(sym)
    -- Get the current mode
    local mode = vim.api.nvim_get_mode().mode
    local is_blockmode = mode == ''

    -- Check if we're in any visual mode
    if not (mode:sub(1, 1) == 'v' or mode:sub(1, 1) == 'V' or mode:sub(1, 1) == '\22') then
        print('toggle_marker: Not in visual mode')
        return
    end

    -- Get the visual selection range
    local start_row, start_col, end_row, end_col = unpack(larp.fn.get_selection_range())

    -- Check if the entire selection is wrapped with the marker
    local first_char = vim.api.nvim_buf_get_text(0, start_row - 1, start_col - 1, start_row - 1, start_col - 1 + #sym, {})[1]
    local last_char = vim.api.nvim_buf_get_text(0, end_row - 1, end_col - #sym, end_row - 1, end_col, {})[1]

    local need_remove = first_char == last_char and first_char == sym

    if need_remove then
        -- Remove markers
        -- Remove the starting marker
        vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, start_row - 1, start_col + #sym - 1, { '' })

        -- Adjust end positions since we've modified the buffer
        if start_row == end_row then
            end_col = end_col - #sym
        else
            -- Multi-line: only adjust end_col for the last line
            end_col = end_col
        end

        -- Remove the ending marker
        vim.api.nvim_buf_set_text(0, end_row - 1, end_col - #sym, end_row - 1, end_col, { '' })
        end_col = end_col - #sym
    else
        -- Add markers
        -- Add the starting marker
        vim.api.nvim_buf_set_text(0, start_row - 1, start_col - 1, start_row - 1, start_col - 1, { sym })

        -- Adjust end positions since we've modified the buffer
        if start_row == end_row then
            end_col = end_col + #sym
        else
            -- Multi-line: only adjust end_col for the last line
            end_col = end_col
        end

        -- Add the ending marker
        vim.api.nvim_buf_set_text(0, end_row - 1, end_col, end_row - 1, end_col, { sym })
        end_col = end_col + 1
    end

    -- Reselect the modified text
    vim.api.nvim_win_set_cursor(0, { start_row, start_col - 1 })
    vim.cmd('normal! ')
    vim.cmd('normal! ' .. mode)
    vim.api.nvim_win_set_cursor(0, { end_row, end_col - 1 })
end

return M

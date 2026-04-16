local M = {}

---@class OrphanInfo
---@field name string
---@field last_commit_date string
---@field days_since_last_commit number
---@field url string

---@param threshold_days number?
function M.check_orphans(threshold_days)
    local exclude = {
        'promise-async',
    }

    threshold_days = threshold_days or 365
    local lazy_config = require('lazy.core.config')
    local plugins = vim.tbl_filter(function(p)
        return not vim.tbl_contains(exclude, p.name)
    end, lazy_config.plugins)
    local all_plugins = {}

    local current_time = os.time()

    for _, plugin in pairs(plugins) do
        if plugin.dir and vim.fn.isdirectory(plugin.dir) == 1 then
            -- Get the last commit date using git (argv form avoids the shell entirely)
            local result = vim.fn.system({ 'git', '-C', plugin.dir, 'log', '-1', '--format=%at' })

            local last_commit_timestamp = vim.v.shell_error == 0 and tonumber(result) or nil
            if last_commit_timestamp then
                local seconds_since = current_time - last_commit_timestamp
                local days_since = math.floor(seconds_since / (24 * 3600))

                table.insert(all_plugins, {
                    name = plugin.name,
                    last_commit_date = os.date('%Y-%m-%d', last_commit_timestamp),
                    days_since_last_commit = days_since,
                    url = plugin.url or 'local',
                })
            end
        end
    end

    -- Sort by days since last commit (descending)
    table.sort(all_plugins, function(a, b)
        return a.days_since_last_commit > b.days_since_last_commit
    end)

    -- Display results
    local lines = { '# Plugin Maintenance Status (Sorted by Last Commit)', '' }
    for _, p in ipairs(all_plugins) do
        local prefix = p.days_since_last_commit > threshold_days and '⚠️ ' or '✅ '
        table.insert(lines, string.format('%s **[%s](%s)**: %d days ago (%s)', prefix, p.name, p.url, p.days_since_last_commit, p.last_commit_date))
    end

    -- Create a temporary buffer to show the results
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.api.nvim_set_option_value('filetype', 'markdown', { buf = buf })
    vim.api.nvim_set_option_value('bufhidden', 'wipe', { buf = buf })

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    vim.api.nvim_open_win(buf, true, {
        relative = 'editor',
        width = width,
        height = height,
        row = row,
        col = col,
        style = 'minimal',
        border = 'rounded',
        title = ' Plugin Maintenance Status ',
        title_pos = 'center',
    })
    ::continue::
end

return M

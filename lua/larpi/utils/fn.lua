local M = {}

---@param action function Action to perform
---@param timeout_ms? integer Timeout in milliseconds
---@return any ret Return value from the `action` function
function M.with_bash(action, timeout_ms)
    local new_shell = vim.fn.has('unix') == 1 and 'bash' or 'cmd.exe'

    if vim.go.shell == new_shell then
        return action()
    end

    timeout_ms = timeout_ms or 100

    vim.o.shell = new_shell
    local ret = action()

    vim.defer_fn(function()
        vim.o.shell = vim.go.shell
    end, timeout_ms)

    return ret
end

---Get highlighted text
---@return string text Highlighted text
function M.get_highlighted_text()
    local start_pos = vim.fn.getpos('v')
    local end_pos = vim.fn.getpos('.')

    local lines = vim.fn.getregion(start_pos, end_pos, { type = vim.fn.mode() })
    local text = table.concat(lines, '\n')

    return text
end

return M

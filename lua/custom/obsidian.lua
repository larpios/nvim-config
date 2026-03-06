local obsidian = require('obsidian')

local workspace_candidates = {
    {
        name = 'default',
        path = '~/obsidian-vault',
    },
    {
        name = 'fallback',
        path = '~/.dotfiles/obsidian-vault',
    },
}

local opts = {
    workspaces = {},
    templates = {
        folder = 'Templates',
    },
    daily_notes = {
        folder = 'journal',
        template = 'Daily Template',
    },
    completion = {
        nvim_cmp = true,
        min_char = 2,
    },
    follow_url_func = function(url)
        vim.fn.jobstart({ 'xdg-open', url })
    end,

    mappings = {
        -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
        ['gf'] = {
            action = function()
                return require('obsidian').util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
        },
        -- Toggle check-boxes.
        ['<leader>ch'] = {
            action = function()
                return require('obsidian').util.toggle_checkbox()
            end,
            opts = { buffer = true },
        },
        -- Smart action depending on context, either follow link or toggle checkbox.
        ['<cr>'] = {
            action = function()
                return require('obsidian').util.smart_action()
            end,
            opts = { buffer = true, expr = true },
        },
    },
    -- picker = {
    --     name = 'fzf-lua',
    --     mappings = {
    --         new = '<C-x>',
    --         insert_link = '<C-l>',
    --     },
    -- },

    ui = {
        enable = true,
        update_debounce = 200, -- update delay after a text change (in milliseconds)
        max_file_length = 5000, -- disable UI features for files with more than this many lines
        checkboxes = {
            [' '] = { char = '󰄱', hl_group = 'ObsidianTodo' },
            ['x'] = { char = '', hl_group = 'ObsidianDone' },
            ['>'] = { char = '', hl_group = 'ObsidianRightArrow' },
            ['~'] = { char = '󰰱', hl_group = 'ObsidianTilde' },
            ['!'] = { char = '', hl_group = 'ObsidianImportant' },
        },
    },
}

for _, candidate in ipairs(workspace_candidates) do
    if vim.fn.isdirectory(vim.fn.expand(candidate.path)) == 1 then
        opts.workspaces[#opts.workspaces + 1] = candidate
    end
end

obsidian.setup(opts)

vim.o.conceallevel = 2

require('nvim-treesitter').setup({
    ensure_installed = { 'markdown', 'markdown_inline' },
    highlight = {
        enable = true,
    },
})

--- Print non-empty job output lines.
local function print_job_output(_, data)
    if data and #data > 0 and data[1] ~= '' then
        vim.print(table.concat(data, '\n'))
    end
end

--- Build common jobstart opts (stdout/stderr forwarded, plus any extras).
local function make_job_opts(extra)
    return vim.tbl_extend('force', {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = print_job_output,
        on_stderr = print_job_output,
    }, extra or {})
end

larp.fn.map('n', '<leader>Ofw', function()
    vim.ui.select(larp.fn.tbl_get_by_key(opts.workspaces, 'name'), {
        prompt = 'Choose your obsidian vault',
    }, function(_, idx)
        vim.cmd('edit ' .. vim.fn.fnameescape(opts.workspaces[idx]['path']))
    end)
end, { desc = 'Search Obsidian Workspace' })
larp.fn.map('n', '<leader>Op', function()
    if #opts.workspaces == 0 then
        vim.notify('No Obsidian workspace found', vim.log.levels.WARN)
        return
    end
    local vault_path = vim.fn.expand(opts.workspaces[1].path)
    vim.fn.jobstart({ 'git', 'pull' }, make_job_opts({
        cwd = vault_path,
        on_exit = function(_, code)
            if code == 0 then
                vim.print('Obsidian Pull: Success')
            else
                vim.print('Obsidian Pull: Failed')
            end
        end,
    }))
    -- pull from git
    local path = vim.fn.expand(opts.workspaces[1].path)
    local output = vim.fn.system({ 'git', '-C', path, 'pull' })
    vim.print(output)
end, { desc = 'Obsidian Pull' })
larp.fn.map('n', '<leader>Os', function()
    if #opts.workspaces == 0 then
        vim.notify('No Obsidian workspace found', vim.log.levels.WARN)
        return
    end
    local vault_path = vim.fn.expand(opts.workspaces[1].path)
    local now = os.date('%Y-%m-%d %H:%M:%S')
    local path = vim.fn.expand(opts.workspaces[1].path)

    -- Chain git operations sequentially via on_exit to avoid shell metacharacter issues.
    local function run_push()
        vim.fn.jobstart({ 'git', 'push' }, make_job_opts({
            cwd = vault_path,
            on_exit = function(_, code)
                if code == 0 then
                    vim.print('Commit and Push Obsidian Vault: Success')
                else
                    vim.print('Commit and Push Obsidian Vault: Failed (push)')
                end
            end,
        }))
    end

    local function run_commit()
        vim.fn.jobstart({ 'git', 'commit', '-m', 'Update ' .. now }, make_job_opts({
            cwd = vault_path,
            on_exit = function(_, code)
                -- git commit exits 1 when there is nothing to commit (working tree clean); still proceed to push
                if code == 0 or code == 1 then
                    run_push()
                else
                    vim.print('Commit and Push Obsidian Vault: Failed (commit)')
                end
            end,
        }))
    end

    local function run_add()
        vim.fn.jobstart({ 'git', 'add', '.' }, make_job_opts({
            cwd = vault_path,
            on_exit = function(_, code)
                if code == 0 then
                    run_commit()
                else
                    vim.print('Commit and Push Obsidian Vault: Failed (add)')
                end
            end,
        }))
    end

    vim.fn.jobstart({ 'git', 'pull' }, make_job_opts({
        cwd = vault_path,
        on_exit = function(_, code)
            if code == 0 then
                run_add()
            else
                vim.print('Commit and Push Obsidian Vault: Failed (pull)')
            end
        end,
    }))
    -- commit and push to git
    local commands = {
        { 'git', '-C', path, 'pull' },
        { 'git', '-C', path, 'add', '.' },
        { 'git', '-C', path, 'commit', '-m', 'Update ' .. now },
        { 'git', '-C', path, 'push' },
    }

    for _, cmd in ipairs(commands) do
        local output = vim.fn.system(cmd)
        local is_commit_cmd = vim.tbl_contains(cmd, 'commit')
        local is_nothing_to_commit = false
        if is_commit_cmd and vim.v.shell_error == 1 and type(output) == 'string' then
            if output:match('nothing to commit') or output:match('no changes added to commit') then
                is_nothing_to_commit = true
            end
        end

        if is_nothing_to_commit then
            vim.print(output)
            -- continue to next command (e.g., git push)
        elseif vim.v.shell_error ~= 0 then
            vim.print(output)
            return
        end
    end
    vim.print('Obsidian vault updated and pushed successfully')
end, { desc = 'Commit and Push Obsidian Vault' })

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    desc = 'Enter Obsidian Vault',
    pattern = '~/notes/obsidian/*',
    callback = function()
        vim.o.conceallevel = 2
    end,
})

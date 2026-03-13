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

vim.keymap.set('n', '<leader>Ofw', function()
    vim.ui.select(larp.fn.tbl_get_by_key(opts.workspaces, 'name'), {
        prompt = 'Choose your obsidian vault',
    }, function(_, idx)
        vim.cmd('edit ' .. vim.fn.fnameescape(opts.workspaces[idx]['path']))
    end)
end, { desc = 'Search Obsidian Workspace', silent = true })
vim.keymap.set('n', '<leader>Op', function()
    -- pull from jj asynchronously
    local path = vim.fn.expand(opts.workspaces[1].path)
    vim.system({ 'sh', '-c', 'jj git fetch' }, { cwd = path, text = true }, function(obj)
        vim.schedule(function()
            if obj.code == 0 then
                vim.notify('Obsidian Pull: Success', vim.log.levels.INFO)
            else
                vim.notify('Obsidian Pull Failed:\n' .. (obj.stderr or obj.stdout or ''), vim.log.levels.ERROR)
            end
        end)
    end)
end, { desc = 'Obsidian Pull', silent = true })
vim.keymap.set('n', '<leader>Os', function()
    local path = vim.fn.expand(opts.workspaces[1].path)
    local now = os.date('%Y-%m-%d %H:%M:%S')
    local path = vim.fn.expand(opts.workspaces[1].path)

    -- Chain git operations sequentially via on_exit to avoid shell metacharacter issues.
    local function run_push()
        vim.fn.jobstart(
            { 'git', 'push' },
            make_job_opts({
                cwd = vault_path,
                on_exit = function(_, code)
                    if code == 0 then
                        vim.print('Commit and Push Obsidian Vault: Success')
                    else
                        vim.print('Commit and Push Obsidian Vault: Failed (push)')
                    end
                end,
            })
        )
    end

    -- Check for conflicts first, then push
    local cmd = 'jj git fetch && '
        .. 'if jj log -r @ --no-graph -T "conflict" | grep -q "true"; then '
        .. 'echo "Conflicts detected!" >&2; exit 1; '
        .. 'else '
        .. 'jj bookmark move main --to @ && jj commit -m "Update '
        .. now
        .. '" && jj git push; '
        .. 'fi'

    vim.system({ 'sh', '-c', cmd }, { cwd = path, text = true }, function(obj)
        vim.schedule(function()
            if obj.code == 0 then
                vim.notify('Obsidian Push: Success\nUpdate ' .. now, vim.log.levels.INFO)
            else
                local err = obj.stderr or obj.stdout or ''
                if err:match('Conflicts detected!') then
                    vim.notify('Obsidian Push Aborted: Conflicts detected! Please resolve before pushing.', vim.log.levels.WARN)
                else
                    vim.notify('Obsidian Push Failed:\n' .. err, vim.log.levels.ERROR)
                end
            end
        end)
    end)
end, { desc = 'Commit and Push Obsidian Vault', silent = true })

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    desc = 'Enter Obsidian Vault',
    pattern = '~/notes/obsidian/*',
    callback = function()
        vim.o.conceallevel = 2
    end,
})

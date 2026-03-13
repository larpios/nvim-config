local snippet_dir = vim.fn.stdpath('config') .. '/snippets'

local opts = {
    keymap = {
        preset = 'default',
        ['<C-q>'] = { 'show_documentation', 'hide_documentation' },
        ['<C-e>'] = { 'show', 'hide' },
    },
    completion = {
        keyword = { range = 'full' },
        list = {
            selection = {
                preselect = false,
                auto_insert = true,
            },
        },
        menu = {
            auto_show = true,
            draw = {
                columns = {
                    { 'item_idx' },
                    { 'kind_icon' },
                    { 'label', 'label_description', gap = 1 },
                    { 'kind' },
                    { 'source_name' },
                },
                components = {
                    kind_icon = {
                        ellipsis = false,
                        text = function(ctx)
                            local kind_icon, _, _ = require('mini.icons').get('lsp', ctx.kind)
                            return kind_icon
                        end,
                        -- Optionally, you may also use the highlights from mini.icons
                        highlight = function(ctx)
                            local _, hl, _ = require('mini.icons').get('lsp', ctx.kind)
                            return hl
                        end,
                    },
                    item_idx = {
                        text = function(ctx)
                            return tostring(ctx.idx)
                        end,
                        highlight = 'BlinkCmpItemIdx', -- optional, only if you want to change its color
                    },
                },
                treesitter = {
                    'lsp',
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 500,
        },
    },
    sources = {
        -- rm ripgrep
        default = { 'lsp', 'path', 'snippets', 'buffer', 'emoji', 'lazydev' },
        providers = {
            ripgrep = {
                module = 'blink-ripgrep',
                name = 'Ripgrep',
                -- the options below are optional, some default values are shown
                ---@module "blink-ripgrep"
                ---@type blink-ripgrep.Options
                opts = {
                    -- For many options, see `rg --help` for an exact description of
                    -- the values that ripgrep expects.

                    -- the minimum length of the current word to start searching
                    -- (if the word is shorter than this, the search will not start)
                    prefix_min_len = 3,

                    -- The number of lines to show around each match in the preview window
                    context_size = 5,

                    -- The maximum file size that ripgrep should include in its search.
                    -- Useful when your project contains large files that might cause
                    -- performance issues.
                    -- Examples: "1024" (bytes by default), "200K", "1M", "1G"
                    max_filesize = '1M',
                },
            },
            snippets = {
                opts = {
                    search_paths = { snippet_dir },
                },
            },
            -- copilot = {
            --     name = "copilot",
            --     module = "blink-cmp-copilot",
            --     score_offset = 100,
            --     async = true,
            -- },
            emoji = {
                module = 'blink-emoji',
                name = 'Emoji',
                score_offset = -1, -- Tune by preference
                opts = { insert = true }, -- Insert emoji (default) or complete its name
            },
            lazydev = {
                name = 'LazyDev',
                module = 'lazydev.integrations.blink',
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
            },
        },
    },
    fuzzy = {
        implementation = 'prefer_rust_with_warning',
    },
    -- snippets = {
    --     preset = 'luasnip',
    -- },
    signature = {
        enabled = true,
    },
    cmdline = {
        enabled = true,
        completion = {
            menu = {
                auto_show = function()
                    return vim.fn.getcmdtype() == ':'
                end,
            },
        },
    },
}

require('blink.cmp').setup(opts)

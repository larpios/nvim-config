local opts = {
    keymap = {
        preset = 'default',
        ['<C-q>'] = { 'show_documentation', 'hide_documentation' },
    },
    completion = {
        menu = {
            border = 'rounded',
            draw = {
                columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
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
            },
        },
        documentation = {
            auto_show = true,
            window = { border = 'rounded' },
        },
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep', 'copilot', 'lazydev', 'dictionary', 'emoji' },
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
            copilot = {
                name = 'copilot',
                module = 'blink-cmp-copilot',
                score_offset = 100,
                async = true,
            },
            lazydev = {
                name = 'LazyDev',
                module = 'lazydev.integrations.blink',
                -- make lazydev completions top priority (see `:h blink.cmp`)
                score_offset = 100,
            },
            dictionary = {
                module = 'blink-cmp-dictionary',
                name = 'Dict',
                -- Make sure this is at least 2.
                -- 3 is recommended
                min_keyword_length = 3,
                opts = {
                    -- options for blink-cmp-dictionary
                },
            },
            emoji = {
                module = 'blink-emoji',
                name = 'Emoji',
                score_offset = 15, -- Tune by preference
                opts = { insert = true }, -- Insert emoji (default) or complete its name
            },
        },
    },
    -- snippets = {
    --     preset = 'luasnip',
    -- },
    signature = {
        enabled = true,
        window = { border = 'rounded' },
    },
}

require('blink.cmp').setup(opts)

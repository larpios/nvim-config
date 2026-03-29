return {
    'saghen/blink.cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
        -- optional: provides snippets for the snippet source
        'rafamadriz/friendly-snippets',
        'mikavilpas/blink-ripgrep.nvim',
        'giuxtaposition/blink-cmp-copilot',
        'moyiz/blink-emoji.nvim',
    },

    -- use a release tag to download pre-built binaries
    version = 'v1.*',
    -- OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    -- build = 'cargo build --release',
    -- On musl libc based systems you need to add this flag
    -- build = 'RUSTFLAGS="-C target-feature=-crt-static" cargo build --release',
    opts = function()
        local snippet_dir = vim.fn.stdpath('config') .. '/snippets'

        return {
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
                per_filetype = {
                    org = { 'orgmode' },
                },
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
                        score_offset = 100,
                    },
                    orgmode = {
                        name = 'Orgmode',
                        module = 'orgmode.org.autocompletion.blink',
                        fallbacks = { 'buffer' },
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
                enabled = false,
                completion = {
                    menu = {
                        auto_show = function()
                            return vim.fn.getcmdtype() == ':'
                        end,
                    },
                },
            },
        }
    end,
}

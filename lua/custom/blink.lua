local opts = {
    keymap = { preset = 'default' },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
    },

    sources = {
        completion = {
            enabled_providers = { 'lsp', 'path', 'snippets', 'buffer', 'ripgrep' },
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
        },
    },
    completion = {
        menu = {
            border = 'rounded',
            winblend = 0,

            draw = {
                columns = { { 'item_idx' }, { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' } },
                components = {
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
            window = {
                border = 'rounded',
                winblend = 0,
            },
        },
    },
}

require('blink.cmp').setup(opts)

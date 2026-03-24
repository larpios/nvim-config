return {
    {
        'ray-x/lsp_signature.nvim',
        event = 'VeryLazy',
        opts = {
            bind = true,
            handle_opts = {
                border = 'rounded',
            },
        },
    },
    {
        'mrcjkb/rustaceanvim',
        version = '^8', -- Recommended
        lazy = false,   -- This plugin is already lazy
    },
    {
        'mason-org/mason.nvim',
        opts = {},
        cmds = {
            'Mason',
            'MasonInstall',
            'MasonLog',
            'MasonUninstall',
            'MasonUninstallAll',
            'MasonUpdate',
        },
        keys = {
            { '<leader>mm', '<cmd>Mason<cr>', desc = '[Mason] Open Mason', silent = true },
        },
    },
    {
        'mason-org/mason-lspconfig.nvim',
        opts = {
            ensure_installed = {
                'vimls',
                'lua_ls',
                'rust_analyzer',
                'clangd',
            },
        },
        dependencies = {
            'mason-org/mason.nvim',
            'neovim/nvim-lspconfig',
        },
    },
    {
        'saecki/crates.nvim',
        ft = 'toml',
        config = function()
            require('crates').setup({
                completion = {
                    cmp = {
                        enabled = true,
                    },
                },
            })
            require('cmp').setup.buffer({
                sources = {
                    { name = 'crates' },
                },
            })
        end,
    },
    {
        -- Better folding
        'kevinhwang91/nvim-ufo',
        event = 'BufRead',
        dependencies = { 'kevinhwang91/promise-async' },
        keys = {
            {
                'zR',
                function()
                    require('ufo').openAllFolds()
                end,
                desc = 'Open all folds',
            },
            {
                'zM',
                function()
                    require('ufo').closeAllFolds()
                end,
                desc = 'Close all folds',
            },
            {
                'zuc',
                function()
                    local level = vim.fn.input('Enter fold level: ')
                    level = tonumber(level)
                    require('ufo').closeFoldsWith(level)
                end,
                desc = 'Close folds with level',
            },
            {
                'z;',
                function()
                    require('ufo.action').goNextClosedFold()
                end,
                desc = 'Go to next closed fold',
            },
            {
                'z,',
                function()
                    require('ufo.action').goPreviousClosedFold()
                end,
                desc = 'Go to previous closed fold',
            },
        },
        init = function()
            vim.o.foldcolumn = '1'
            vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
        end,
        config = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities.textDocument.foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
            }
            local language_servers = require('lspconfig').util.available_servers() -- or list servers manually like {'gopls', 'clangd'}
            for _, ls in ipairs(language_servers) do
                require('lspconfig')[ls].setup({
                    capabilities = capabilities,
                    -- you can add other fields for setting up lsp server in this table
                })
            end
            local handler = function(virtText, lnum, endLnum, width, truncate)
                local newVirtText = {}
                local suffix = (' 󰁂 %d '):format(endLnum - lnum)
                local sufWidth = vim.fn.strdisplaywidth(suffix)
                local targetWidth = width - sufWidth
                local curWidth = 0
                for _, chunk in ipairs(virtText) do
                    local chunkText = chunk[1]
                    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
                    if targetWidth > curWidth + chunkWidth then
                        table.insert(newVirtText, chunk)
                    else
                        chunkText = truncate(chunkText, targetWidth - curWidth)
                        local hlGroup = chunk[2]
                        table.insert(newVirtText, { chunkText, hlGroup })
                        chunkWidth = vim.fn.strdisplaywidth(chunkText)
                        -- str width returned from truncate() may less than 2nd argument, need padding
                        if curWidth + chunkWidth < targetWidth then
                            suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
                        end
                        break
                    end
                    curWidth = curWidth + chunkWidth
                end
                table.insert(newVirtText, { suffix, 'MoreMsg' })
                return newVirtText
            end

            require('ufo').setup({
                fold_virt_text_handler = handler,
            })
        end,
    },
    {
        'neovim/nvim-lspconfig',
    },
    {
        -- Stops inactive LSP servers to free RAM
        'zeioth/garbage-day.nvim',
        dependencies = 'neovim/nvim-lspconfig',
        event = 'VeryLazy',
        opts = {},
    },
    {
        'stevearc/aerial.nvim',
        -- just to test symbols.nvim
        -- enabled = false,
        event = 'BufRead',
        opts = {
            -- optionally use on_attach to set keymaps when aerial has attached to a buffer
            on_attach = function(bufnr)
                -- Jump forwards/backwards with '{' and '}'
                vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
                vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
            end,
            autojump = true,
            filter_kind = false,
        },
        -- Optional dependencies
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
            'nvim-tree/nvim-web-devicons',
        },

        keys = {
            { '<leader>to', '<cmd>AerialToggle<cr>', desc = 'Toggle Aerial Overview' },
        },
    },
    {
        -- Overview panel, something like aerial
        'oskarrrrrrr/symbols.nvim',
        enabled = false,
        cmds = {
            'Symbols',
            'SymbolsOpen',
            'SymbolsClose',
        },
        keys = {
            { '<leader>ts', mode = 'n',                desc = 'Toggle Symbols' },
            { ',s',         '<cmd> Symbols<CR>',       desc = 'Symbols' },
            { ',S',         '<cmd> SymbolsClose<CR>',  desc = 'Symbols Close' },
            { 'ts',         '<cmd> SymbolsToggle<CR>', desc = 'Symbols Toggle' },
        },
        config = function()
            local opts = {
                sidebar = {
                    hide_cursor = false,
                    auto_peek = true,
                    show_guide_lines = true,
                },
            }
            local r = require('symbols.recipes')
            require('symbols').setup(r.DefaultFilters, r.AsciiSymbols, opts)
        end,
    },
    {
        'saghen/blink.cmp',
        event = 'InsertEnter',
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
                                { 'label',      'label_description', gap = 1 },
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
                        org = { 'orgmode' }
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
                            score_offset = -1,        -- Tune by preference
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
        end,
    },
    {
        -- Shows refernce and definition info above functions
        'VidocqH/lsp-lens.nvim',
        event = 'LspAttach',
        opts = {},
    },
    {
        'mfussenegger/nvim-jdtls',
        enabled = false,
        ft = 'java',
    },
    {
        'p00f/clangd_extensions.nvim',
        ft = { 'c', 'cpp' },
        opts = {},
    },
    {
        'pest-parser/pest.vim',
        ft = 'pest',
    },
    {
        'rachartier/tiny-inline-diagnostic.nvim',
        enabled = false,
        event = 'VeryLazy', -- Or `LspAttach`
        priority = 1000,    -- needs to be loaded in first
        config = function()
            require('tiny-inline-diagnostic').setup()
            vim.diagnostic.config({ virtual_text = false }) -- Only if needed in your configuration, if you already have native LSP diagnostics
        end,
    },
    {
        'Civitasv/cmake-tools.nvim',
        ft = { 'cmake' },
        opts = {},
    },
    {
        -- Formatter
        'stevearc/conform.nvim',
        event = { 'BufRead' },
        cmd = { 'ConformInfo' },
        opts = {
            formatters_by_ft = {
                bash = { 'beautysh', 'shfmt', 'shellharden' },
                c = { 'clang_format' },
                cmake = { 'cmake_format' },
                cpp = { 'clang_format' },
                cs = { 'csharpier', 'clang_format' },
                fish = { 'fish_lsp' },
                js = { 'prettier', 'eslint_d' },
                lua = { 'stylua' },
                markdown = { 'injected', 'prettier', 'markdownfmt', 'markdownlint', 'markdownlint-cli2' },
                nix = { 'injected', 'alejandra', 'nixpkgs-fmt', 'nixfmt' },
                nu = { 'injected', 'nufmt' },
                org = { 'injected', 'orgfmt' },
                python = { 'ruff', 'autopep8', 'autoflake', 'black' },
                rust = { 'rustfmt' },
                svelte = { 'prettier', 'eslint_d' },
                text = { 'autocorrect' },
                ts = { 'prettier', 'eslint_d' },
                typst = { 'prettypst', 'typstyle' },
                xml = { 'xmlformat' },
                yaml = { 'yamllint', 'prettier' },
                kdl = { 'kdlfmt' },
            },
            default_format_opts = {
                lsp_format = 'fallback',
            },
            -- format_after_save = {
            --     lsp_format = 'fallback',
            --     timeout_ms = 500,
            -- },
            -- Conform will notify you when no formatters are available for the buffer
            notify_no_formatters = true,
        },
        keys = {
            {
                '<leader>cf',
                function()
                    require('conform').format({
                        async = true, -- might cause a problem where your changes are overwritten by the formatter
                        lsp_fallback = true,
                    })
                end,
                desc = '[Conform] Format Document',
            },
        },
    },
    {
        -- Enables inline syntax highlighting using a tree-sitter parser
        -- For example, inside multiline strings in Nix or Markdown
        'jmbuhr/otter.nvim',
        -- 'larpios/otter.nvim',
        -- branch = 'test',
        event = 'VeryLazy',
        dependencies = {
            'nvim-treesitter/nvim-treesitter',
        },
        opts = {
            buffers = {
                set_filetype = true,
                write_to_disk = true,
            },
            extensions = {
                ['bash'] = 'sh',
            },
        },
    },
}

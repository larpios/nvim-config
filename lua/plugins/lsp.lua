return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/nvim-cmp",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",

            -- Luasnip
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",

            -- Lspsaga
            {
                "nvimdev/lspsaga",
                config = function()
                    require("lspsaga").setup({})
                    require("lspsaga.symbol.winbar").get_bar()
                end,
                dependencies = {
                    "nvim-treesitter/nvim-treesitter", -- optional
                    "nvim-tree/nvim-web-devicons",     -- optional
                },

            }
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                desc = 'LSP actions',
                callback = function(event)
                    map = function(mode, lhs, rhs, opts)
                        local new_opts = { buffer = event.buf }
                        for k, v in pairs(opts) do
                            new_opts[k] = v
                        end
                        vim.keymap.set(mode, lhs, rhs, new_opts)
                    end

                    -- these will be buffer-local keybindings
                    -- because they only work if you have an active language server

                    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = "Hover" })
                    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', { desc = "Go to Definition" })
                    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', { desc = "Go to Declaration" })
                    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = "Go to implementation" })
                    map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = "Go to Type Definition" })
                    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', { desc = "Go to References" })
                    map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = "Signature Help" })
                    map('n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<cr>', { desc = "Rename Symbol" })
                    map({ 'n', 'x' }, '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
                        { desc = "Format Buffer" })
                    map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<cr>', { desc = "Code Actions" })

                    vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
                end
            })

            local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

            local lsp_config = require('lspconfig')
            local default_setup = function(server)
                lsp_config[server].setup({
                    capabilities = lsp_capabilities
                })
            end

            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "rust_analyzer",
                    "clangd",
                    "bashls",
                    "html",
                    "cssls",
                    "jsonls",
                    "yamlls",
                    "bashls",
                    "pylsp",
                    "pylyzer",
                    "pyright",
                    "rust_analyzer",
                    "clangd",
                    "cmake",
                    "kotlin_language_server",
                    "vimls",
                    "lua_ls",
                },
                handlers = {
                    default_setup,
                },
                automatic_installation = true,
            })

            local cmp = require('cmp')

            cmp.setup({
                sources = {
                    { name = 'luasnip', option = { show_autosnippets = true } },
                    { name = "nvim_lsp" },
                },
                mapping = cmp.mapping.preset.insert({
                    -- Confirm selection
                    ['<c-y>'] = cmp.mapping.confirm({ select = false }),

                    -- Trigger completion menu
                    ['<c-space'] = cmp.mapping.complete(),

                    ['<c-e>'] = cmp.mapping.abort(),
                }),
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end
                },
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                -- A list of parser names, or "all" (the listed parsers MUST always be installed)
                ensure_installed = { "c", "cpp", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "rust" },

                -- Install parsers synchronously (only applied to `ensure_installed`)
                sync_install = false,

                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = true,

                ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
                -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

                highlight = {
                    enable = true,

                    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
                    disable = function(lang, buf)
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,

                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
    },
    {
        "mrcjkb/rustaceanvim",
        version = "^5", -- Recommended
        lazy = false,   -- This plugin is already lazy
    },

    --[[ {
        "L3MON4D3/LuaSnip",
        event = "BufEnter",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",
        config = function()
            local ls = require("luasnip")

            vim.keymap.set({"i"}, "<C-K>", function() ls.expand() end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-L>", function() ls.jump( 1) end, {silent = true})
            vim.keymap.set({"i", "s"}, "<C-J>", function() ls.jump(-1) end, {silent = true})

            vim.keymap.set({"i", "s"}, "<C-E>", function()
                if ls.choice_active() then
                    ls.change_choice(1)
                end
            end, {silent = true})
        end

    }, ]]

    { "onsails/lspkind.nvim" },
    {
        "nvimdev/lspsaga.nvim",
        config = function()
            local lspsaga = require("lspsaga").setup({})
            require("lspsaga.symbol.winbar").get_bar()
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "Lsp Actions",
                callback = function(opts)
                    vim.keymap.set("n", "<leader>", lspsaga)
                end
            })
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter", -- optional
            "nvim-tree/nvim-web-devicons",     -- optional
        },
    },
}

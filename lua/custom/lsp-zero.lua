local lsp_zero = require('lsp-zero')
local cmp = require('cmp')
local cmp_action = lsp_zero.cmp_action()
local cmp_format = lsp_zero.cmp_format({ details = true })
cmp_format.format = require('lspkind').cmp_format({
    mode = 'symbol_text',
    maxwidth = 50,
    ellipsis_char = '...',
    show_labelDetails = true, -- show labelDetails in menu. Disabled by default

    -- The function below will be called before any actual modifications from lspkind
    -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
    before = function(entry, vim_item)
        return vim_item
    end,
})

require('luasnip.loaders.from_vscode').lazy_load({
    paths = {
        vim.fn.stdpath('config') .. '/snippets',
    },
})
-- `/` cmdline setup.
-- cmp.setup({
--     preselect = 'item',
--     completion = {
--         completeopt = 'menu,menuone,noinsert,popup',
--     },
--
--     sources = {
--         { name = 'nvim_lsp' },
--         {
--             name = 'luasnip',
--             option = {
--                 use_show_condition = false,
--                 show_autosnippets = true,
--             },
--         },
--         {
--             name = 'buffer',
--             option = {
--                 keyword_pattern = [[\k+]],
--                 get_bufnrs = function()
--                     return vim.api.nvim_list_bufs()
--                 end,
--             },
--         },
--         { name = 'orgmode' },
--         { name = 'neorg' },
--         -- sorting = {
--         --     comparators = {
--         --         function(...)
--         --             return require('cmp-buffer').compare_locality(...)
--         --         end,
--         --         cmp.config.compare.offset,
--         --         cmp.config.compare.exact,
--         --         cmp.config.compare.score,
--         --         cmp.config.compare.kind,
--         --         cmp.config.compare.length,
--         --         cmp.config.compare.order,
--         --         cmp.config.compare.alphabet,
--         --         cmp.config.compare.substr,
--         --         cmp.config.compare.fuzzy,
--         --     },
--         -- },
--     },
--     window = {
--         completion = cmp.config.window.bordered(),
--         documentation = cmp.config.window.bordered(),
--     },
--     formatting = cmp_format,
--
--     mapping = cmp.mapping.preset.insert({
--         ['<c-f>'] = cmp_action.luasnip_jump_forward(),
--         ['<c-b>'] = cmp_action.luasnip_jump_backward(),
--     }),
--     snippet = {
--         expand = function(args)
--             require('luasnip').lsp_expand(args.body)
--         end,
--     },
-- })
-- LSP Setup

lsp_zero.setup({})
lsp_zero.on_attach(function(client, bufnr)
    lsp_zero.default_keymaps({
        buffer = bufnr,
        preserve_mappings = false,
        exclude = {
            '<F1>',
            '<F2>',
            '<F3>',
            '<F4>',
        },
    })
    if client.server_capabilities.document_formatting then
        larp.fn.map('n', '<leader>cf', '<cmd>lua vim.lsp.buf.formatting()<cr>', { buffer = bufnr })
    end
    if client.server_capabilities.inlayHintProvider then
        vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end
end)

local cap = require('cmp_nvim_lsp').default_capabilities()
cap.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
}
lsp_zero.extend_lspconfig({
    capabilities = cap,
})

vim.g.rustaceanvim = {
    server = {
        capabilities = vim.lsp.protocol.make_client_capabilities(),
        default_settings = {
            ['rust-analyzer'] = {
                cmd = { '~/.cargo/bin/rust-analyzer' },
                cargo = {
                    allFeatures = true,
                },
                diagnostics = {
                    enable = true,
                    experimental = {
                        enable = true,
                    },
                },
            },
        },
    },
}

require('mason').setup({
    ui = {
        icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
        },
    },
})
larp.fn.map('n', '<leader>mm', ':Mason<CR>', { noremap = true, silent = true, desc = 'Mason' })
require('mason-lspconfig').setup({
    ensure_installed = {
        'vimls',
        'ts_ls',
        'bashls',
        'pyright',
        'marksman',
        'graphql',
    },
    automatic_installation = true,
    handlers = {
        function(server_name)
            require('lspconfig')[server_name].setup({})
        end,
        lua_ls = function()
            require('lspconfig').lua_ls.setup({
                on_init = function(client)
                    lsp_zero.nvim_lua_settings(client, {})
                end,
            })
        end,
        rust_analyzer = lsp_zero.noop,
    },
})

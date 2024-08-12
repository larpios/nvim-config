return {
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'black' },
          rust = { 'rustfmt' },
          c = { 'clang-format' },
          cpp = { 'clang-format' },
          cmake = { 'cmake-format' },
        },
      }

      vim.keymap.set('n', '<leader>cf', "<cmd>lua require('conform').format()<cr>")
    end,
  },

  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
  },

  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v4.x',
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'L3MON4D3/LuaSnip' },
      { 'onsails/lspkind.nvim' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },
      { 'mrcjkb/rustaceanvim' },
    },
    config = function()
      local lsp_zero = require 'lsp-zero'
      local cmp = require 'cmp'
      local cmp_action = lsp_zero.cmp_action()
      local cmp_format = lsp_zero.cmp_format { details = true }

      cmp.setup {
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        formatting = {
          fields = { 'abbr', 'kind', 'menu' },
          format = require('lspkind').cmp_format {
            mode = 'symbol', -- show only symbol annotations
            maxwidth = 50, -- prevent the popup from showing more than provided characters
            ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead
          },
        },
        mapping = {
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.close(),
          ['<C-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Insert,
            select = true,
          },
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
      }

      lsp_zero.setup {}

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps { buffer = bufnr, exclude = { '<F2>', '<F3>', '<F4>' } }
      end)

      lsp_zero.extend_lspconfig {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      }

      vim.g.rustaceanvim = {
        server = {
          capabilities = lsp_zero.get_capabilities(),
        },
      }

      require('mason').setup {}
      require('mason-lspconfig').setup {
        ensure_installed = { 'lua_ls', 'rust_analyzer', 'clangd' },
        handlers = {
          function(server_name)
            require('lspconfig')[server_name].setup {}
          end,
          lua_ls = function()
            require('lspconfig').lua_ls.setup {
              on_init = function(client)
                lsp_zero.nvim_lua_settings(client, {})
              end,
            }
          end,
          rust_analyzer = lsp_zero.noop,
        },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
  },
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup {}
      require('lspsaga.symbol.winbar').get_bar()
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons', -- optional
    },
  },

  {
    'williamboman/mason.nvim',
    dependencies = {
      'williamboman/mason-lspconfig.nvim',
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = {
          'html',
          'cssls',
          'jsonls',
          'yamlls',
          'tsserver',
          'bashls',
          'pylsp',
          'pylyzer',
          'pyright',
          'rust_analyzer',
          'clangd',
          'cmake',
          'kotlin_language_server',
          'vimls',
          'marksman',
          'graphql',
          'lua_ls',
        },
      }
    end,
  },
  {
    'nvimtools/none-ls.nvim',
    enabled = false,
    config = function()
      local null_ls = require 'null-ls'

      null_ls.setup {
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.completion.spell,
        },
      }
    end,
  },
}

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        -- A list of parser names, or "all" (the listed parsers MUST always be installed)
        ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query', 'markdown', 'markdown_inline', 'rust' },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,

        -- List of parsers to ignore installing (or "all")
        ignore_install = { 'javascript' },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          disable = { 'c', 'rust' },
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
      }
    end,
  },
  {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
      require('conform').setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'black' },
          rust = { 'rustfmt' },
          c = { 'clang_format' },
          cpp = { 'clang_format' },
          cmake = { 'cmake_format' },
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

      require('mason').setup {
        ui = {
          icons = {
            package_installed = '✓',
            package_pending = '➜',
            package_uninstalled = '✗',
          },
        },
      }
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
  {
    'neoclide/coc.nvim',
    config = function()
      vim.opt.backup = false
      vim.opt.writebackup = false

      -- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
      -- delays and poor user experience
      vim.opt.updatetime = 300

      -- Always show the signcolumn, otherwise it would shift the text each time
      -- diagnostics appeared/became resolved
      vim.opt.signcolumn = 'yes'

      local keyset = vim.keymap.set
      -- Autocomplete
      function _G.check_back_space()
        local col = vim.fn.col '.' - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match '%s' ~= nil
      end

      -- Use Tab for trigger completion with characters ahead and navigate
      -- NOTE: There's always a completion item selected by default, you may want to enable
      -- no select by setting `"suggest.noselect": true` in your configuration file
      -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
      -- other plugins before putting this into your config
      local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
      keyset('i', '<TAB>', 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
      keyset('i', '<S-TAB>', [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

      -- Make <CR> to accept selected completion item or notify coc.nvim to format
      -- <C-g>u breaks current undo, please make your own choice
      keyset('i', '<cr>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

      -- Use <c-j> to trigger snippets
      keyset('i', '<c-j>', '<Plug>(coc-snippets-expand-jump)')
      -- Use <c-space> to trigger completion
      keyset('i', '<c-space>', 'coc#refresh()', { silent = true, expr = true })
      -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
      keyset('n', '[g', '<Plug>(coc-diagnostic-prev)', { silent = true })
      keyset('n', ']g', '<Plug>(coc-diagnostic-next)', { silent = true })

      -- GoTo code navigation
      keyset('n', 'gd', '<Plug>(coc-definition)', { silent = true })
      keyset('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
      keyset('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
      keyset('n', 'gr', '<Plug>(coc-references)', { silent = true })

      -- Use K to show documentation in preview window
      function _G.show_docs()
        local cw = vim.fn.expand '<cword>'
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval 'coc#rpc#ready()' then
          vim.fn.CocActionAsync 'doHover'
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end
      keyset('n', 'K', '<CMD>lua _G.show_docs()<CR>', { silent = true })

      -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
      vim.api.nvim_create_augroup('CocGroup', {})
      vim.api.nvim_create_autocmd('CursorHold', {
        group = 'CocGroup',
        command = "silent call CocActionAsync('highlight')",
        desc = 'Highlight symbol under cursor on CursorHold',
      })

      -- Symbol renaming
      keyset('n', '<leader>rn', '<Plug>(coc-rename)', { silent = true })

      -- Formatting selected code
      keyset('x', '<leader>f', '<Plug>(coc-format-selected)', { silent = true })
      keyset('n', '<leader>f', '<Plug>(coc-format-selected)', { silent = true })

      -- Setup formatexpr specified filetype(s)
      vim.api.nvim_create_autocmd('FileType', {
        group = 'CocGroup',
        pattern = 'typescript,json',
        command = "setl formatexpr=CocAction('formatSelected')",
        desc = 'Setup formatexpr specified filetype(s).',
      })

      -- Update signature help on jump placeholder
      vim.api.nvim_create_autocmd('User', {
        group = 'CocGroup',
        pattern = 'CocJumpPlaceholder',
        command = "call CocActionAsync('showSignatureHelp')",
        desc = 'Update signature help on jump placeholder',
      })

      -- Apply codeAction to the selected region
      -- Example: `<leader>aap` for current paragraph
      local opts = { silent = true, nowait = true }
      keyset('x', '<leader>a', '<Plug>(coc-codeaction-selected)', opts)
      keyset('n', '<leader>a', '<Plug>(coc-codeaction-selected)', opts)

      -- Remap keys for apply code actions at the cursor position.
      keyset('n', '<leader>ac', '<Plug>(coc-codeaction-cursor)', opts)
      -- Remap keys for apply source code actions for current file.
      keyset('n', '<leader>as', '<Plug>(coc-codeaction-source)', opts)
      -- Apply the most preferred quickfix action on the current line.
      keyset('n', '<leader>qf', '<Plug>(coc-fix-current)', opts)

      -- Remap keys for apply refactor code actions.
      keyset('n', '<leader>re', '<Plug>(coc-codeaction-refactor)', { silent = true })
      keyset('x', '<leader>r', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })
      keyset('n', '<leader>r', '<Plug>(coc-codeaction-refactor-selected)', { silent = true })

      -- Run the Code Lens actions on the current line
      keyset('n', '<leader>cl', '<Plug>(coc-codelens-action)', opts)

      -- Map function and class text objects
      -- NOTE: Requires 'textDocument.documentSymbol' support from the language server
      keyset('x', 'if', '<Plug>(coc-funcobj-i)', opts)
      keyset('o', 'if', '<Plug>(coc-funcobj-i)', opts)
      keyset('x', 'af', '<Plug>(coc-funcobj-a)', opts)
      keyset('o', 'af', '<Plug>(coc-funcobj-a)', opts)
      keyset('x', 'ic', '<Plug>(coc-classobj-i)', opts)
      keyset('o', 'ic', '<Plug>(coc-classobj-i)', opts)
      keyset('x', 'ac', '<Plug>(coc-classobj-a)', opts)
      keyset('o', 'ac', '<Plug>(coc-classobj-a)', opts)

      -- Remap <C-f> and <C-b> to scroll float windows/popups
      ---@diagnostic disable-next-line: redefined-local
      local opts = { silent = true, nowait = true, expr = true }
      keyset('n', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
      keyset('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
      keyset('i', '<C-f>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
      keyset('i', '<C-b>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
      keyset('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
      keyset('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

      -- Use CTRL-S for selections ranges
      -- Requires 'textDocument/selectionRange' support of language server
      keyset('n', '<C-s>', '<Plug>(coc-range-select)', { silent = true })
      keyset('x', '<C-s>', '<Plug>(coc-range-select)', { silent = true })

      -- Add `:Format` command to format current buffer
      vim.api.nvim_create_user_command('Format', "call CocAction('format')", {})

      -- " Add `:Fold` command to fold current buffer
      vim.api.nvim_create_user_command('Fold', "call CocAction('fold', <f-args>)", { nargs = '?' })

      -- Add `:OR` command for organize imports of the current buffer
      vim.api.nvim_create_user_command('OR', "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})

      -- Add (Neo)Vim's native statusline support
      -- NOTE: Please see `:h coc-status` for integrations with external plugins that
      -- provide custom statusline: lightline.vim, vim-airline
      vim.opt.statusline:prepend "%{coc#status()}%{get(b:,'coc_current_function','')}"

      -- Mappings for CoCList
      -- code actions and coc stuff
      ---@diagnostic disable-next-line: redefined-local
      local opts = { silent = true, nowait = true }
      -- Show all diagnostics
      keyset('n', '<space>a', ':<C-u>CocList diagnostics<cr>', opts)
      -- Manage extensions
      keyset('n', '<space>e', ':<C-u>CocList extensions<cr>', opts)
      -- Show commands
      keyset('n', '<space>c', ':<C-u>CocList commands<cr>', opts)
      -- Find symbol of current document
      keyset('n', '<space>o', ':<C-u>CocList outline<cr>', opts)
      -- Search workspace symbols
      keyset('n', '<space>s', ':<C-u>CocList -I symbols<cr>', opts)
      -- Do default action for next item
      keyset('n', '<space>j', ':<C-u>CocNext<cr>', opts)
      -- Do default action for previous item
      keyset('n', '<space>k', ':<C-u>CocPrev<cr>', opts)
      -- Resume latest coc list
      keyset('n', '<space>p', ':<C-u>CocListResume<cr>', opts)
      -- Use `[g` and `]g`
    end,
  },
}

return {
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup({
        lsp = {
          signature = { enabled = false },
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      })
      vim.api.nvim_create_autocmd('RecordingEnter', {
        callback = function()
          local msg = string.format('Register:  %s', vim.fn.reg_recording())
          _MACRO_RECORDING_STATUS = true
          vim.notify(msg, vim.log.levels.INFO, {
            title = 'Macro Recording',
            keep = function()
              return _MACRO_RECORDING_STATUS
            end,
          })
        end,
        group = vim.api.nvim_create_augroup('NoiceMacroNotfication', { clear = true }),
      })

      vim.api.nvim_create_autocmd('RecordingLeave', {
        callback = function()
          _MACRO_RECORDING_STATUS = false
          vim.notify('Success!', vim.log.levels.INFO, {
            title = 'Macro Recording End',
            timeout = 2000,
          })
        end,
        group = vim.api.nvim_create_augroup('NoiceMacroNotficationDismiss', { clear = true }),
      })
    end,
  },
  {

    'lambdalisue/vim-suda',
    config = function()
      vim.keymap.set('n', '<leader><leader>w', ':SudaWrite<CR>', { noremap = true })
      vim.keymap.set('n', '<leader><leader>r', ':SudaRead<CR>', { noremap = true })
    end,
  },
  {
    'ziontee113/color-picker.nvim',
    event = 'BufEnter',
    keys = {
      { '<leader>uc' },
      { '<c-e>uc', mode = 'i' },
    },
    config = function()
      local get_opts = function(tbl)
        local new_opts = { noremap = true, silent = true }
        for k, v in pairs(tbl) do
          new_opts[k] = v
        end
        return new_opts
      end
      vim.keymap.set('n', '<leader>uc', '<cmd>PickColor<cr>', get_opts({ desc = 'Open Color Picker' }))
      vim.keymap.set('i', '<c-e>uc', '<cmd>PickColor<cr>', get_opts({ desc = 'Open Color Picker' }))
    end,
  },
  {
    'LintaoAmons/bookmarks.nvim',
    -- tag = "v0.5.4", -- optional, pin the plugin at specific version for stability
    dependencies = {
      { 'nvim-telescope/telescope.nvim' },
      { 'stevearc/dressing.nvim' }, -- optional: to have the same UI shown in the GIF
    },

    config = function()
      vim.keymap.set({ 'n', 'v' }, 'mm', '<cmd>BookmarksMark<cr>', { desc = 'Mark current line into active BookmarkList.' })
      vim.keymap.set({ 'n', 'v' }, 'mo', '<cmd>BookmarksGoto<cr>', { desc = 'Go to bookmark at current active BookmarkList' })
      vim.keymap.set({ 'n', 'v' }, 'ma', '<cmd>BookmarksCommands<cr>', { desc = 'Find and trigger a bookmark command.' })
      vim.keymap.set({ 'n', 'v' }, 'mg', '<cmd>BookmarksGotoRecent<cr>', { desc = 'Go to latest visited/created Bookmark' })
    end,
  },
  {
    'ibhagwan/fzf-lua',
    -- optional for icon support
    dependencies = {
      'nvim-tree/nvim-web-devicons',
      { 'junegunn/fzf', build = './install --bin' },
    },
    config = function()
      local fzf = require('fzf-lua')
      -- calling `setup` is optional for customization
      fzf.setup({
        'fzf-native',
        hls = {
          Rg = {
            cmd = 'rg --vimgrep --no-heading --smart-case',
            previewer = 'bat',
          },
        },
      })

      vim.keymap.set({ 'i' }, '<C-x><C-f>', function()
        fzf.complete_file({
          cmd = 'rg --files',
          winopts = { preview = { hidden = 'nohidden' } },
        })
      end, { silent = true, desc = 'Fuzzy complete file' })
    end,
  },
  {
    'mfussenegger/nvim-dap',
  },
  {
    'debugloop/telescope-undo.nvim',
    dependencies = {
      {
        'nvim-telescope/telescope.nvim',
        dependencies = { 'nvim-lua/plenary.nvim' },
      },
    },
    keys = {
      '<leader>fu',
      '<cmd>Telescope undo<cr>',
      desc = 'Undo History',
    },
    opts = {
      extensions = {
        undo = {
          side_by_side = true,
        },
      },
    },

    config = function(_, opts)
      local telescope = require('telescope')
      telescope.setup(opts)
      telescope.load_extension('undo')
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.6',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      'BurntSushi/ripgrep',
      'sharkdp/fd',
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local telescope = require('telescope')
      local actions = require('telescope.actions')
      telescope.setup({
        defaults = {
          path_display = { 'truncate ' }, -- Example configuration
          mappings = {
            i = {
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
      })
      --[[ local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fc', builtin.commands, { desc = 'Find Commands' })
    vim.keymap.set('n', '<leader>fl', builtin.live_grep, { desc = 'Find Live Grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Find Buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Find Help Tags' })
    vim.keymap.set('n', '<leader>fq', builtin.quickfix, { desc = 'Find Quickfix' })
    vim.keymap.set('n', '<leader>fj', builtin.jumplist, { desc = 'Find Jumplist' })
    vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Find Old Files' })
    vim.keymap.set('n', '<leader>fr', builtin.registers, { desc = 'Find Registers' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = 'Find Keymaps' })
    vim.keymap.set('n', '<leader>fv', builtin.vim_options, { desc = 'Find Vim Options' }) ]]
    end,
  },
  {
    'gelguy/wilder.nvim',
    config = true,
  },
}

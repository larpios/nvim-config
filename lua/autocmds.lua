vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', {}),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP Actions',
  callback = function(event)
    local map = function(mode, lhs, rhs, opts)
      local default_opts = { silent = true, noremap = true, buffer = event.buf }
      if opts then
        for k, v in pairs(opts) do
          default_opts[k] = v
        end
      end
      vim.keymap.set(mode, lhs, rhs, default_opts)
    end
    map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code Action' })
    map('n', '<leader>ch', vim.diagnostic.open_float, { desc = 'Show Diagnostic Message' })
    map('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename Symbol' })
    map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to Definition' })
    map('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to Declaration' })
    map('n', 'gr', vim.lsp.buf.references, { desc = 'Go to References' })
    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', { desc = 'Show Hover' })
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', { desc = 'Go to Implementation' })
    map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', { desc = 'Go to Type Definition' })
    map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', { desc = 'Show Signature Help' })
    map({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', { desc = 'Format' })
  end,
})

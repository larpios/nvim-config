return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  opts = {
      hide = {
          tabline = true,
      }
  },
  config = function()
    require('dashboard').setup({
      -- config
    })
  end,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } },
}

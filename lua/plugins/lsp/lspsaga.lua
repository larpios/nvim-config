return {
  'nvimdev/lspsaga.nvim',
  enable = false,
  config = function()
    require('lspsaga').setup {}
    require('lspsaga.symbol.winbar').get_bar()
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter', -- optional
    'nvim-tree/nvim-web-devicons', -- optional
  },
}

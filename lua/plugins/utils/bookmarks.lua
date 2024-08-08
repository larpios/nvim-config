-- with lazy.nvim
return {
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
}

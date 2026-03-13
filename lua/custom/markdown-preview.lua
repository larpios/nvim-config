vim.g.mkdp_preview_options = {
    uml = {
        imageFormat = 'svg',
    },
}
vim.g.mkdp_theme = 'dark'

vim.keymap.set('n', '<leader>mds', '<cmd>MarkdownPreview<cr>', { desc = 'Start Markdown Preview' })
vim.keymap.set('n', '<leader>mdS', '<cmd>MarkdownPreviewStop<cr>', { desc = 'Stop Markdown Preview' })
vim.keymap.set('n', '<leader>mdr', '<cmd>MarkdownPreviewStop<cr><cmd>MarkdownPreview<cr>', { desc = 'Restart Markdown Preview' })

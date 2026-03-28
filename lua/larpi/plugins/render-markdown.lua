return {
    -- live-preview markdown
    'MeanderingProgrammer/render-markdown.nvim',
    cmd = { 'RenderMarkdown' },
    ft = { 'markdown', 'vimwiki' },
    opts = {
        file_types = { 'markdown', 'vimwiki' },
        completions = {
            lsp = {
                enabled = true,
            },
            blink = {
                enabled = true,
            },
        },
    },
    init = function()
        vim.treesitter.language.register('markdown', 'markdown')
    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
        'nvim-mini/mini.nvim',
        {
            'epwalsh/obsidian.nvim',
            optional = true,
            config = function()
                require('obsidian').get_client().opts.ui.enable = false
                vim.api.nvim_buf_clear_namespace(0, vim.api.nvim_get_namespaces()['ObsidianUI'], 0, -1)
            end,
        },
    },
}

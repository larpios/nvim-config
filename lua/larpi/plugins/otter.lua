return {
    -- Enables inline syntax highlighting using a tree-sitter parser
    -- For example, inside multiline strings in Nix or Markdown
    'jmbuhr/otter.nvim',
    -- 'larpios/otter.nvim',
    -- branch = 'test',
    event = 'VeryLazy',
    dependencies = {
        'nvim-treesitter/nvim-treesitter',
    },
    opts = {
        buffers = {
            set_filetype = true,
            write_to_disk = true,
        },
        extensions = {
            ['bash'] = 'sh',
        },
    },
}

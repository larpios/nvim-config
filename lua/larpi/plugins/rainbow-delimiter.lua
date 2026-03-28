return {
    'HiPhish/rainbow-delimiters.nvim',
    dependencies = 'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPre', 'BufNewFile' },
    init = function()
        vim.g.rainbow_delimiters = {
            strategy = {
                [''] = 'rainbow-delimiters.strategy.global',
            },
            query = {
                [''] = 'rainbow-delimiters',
            },
            condition = function(bufnr)
                local ft = vim.bo[bufnr].filetype
                if ft == '' then
                    return false
                end
                local lang = vim.treesitter.language.get_lang(ft)
                if not lang then
                    return false
                end
                local ok, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
                return ok and parser ~= nil
            end,
            blacklist = {
                'oil',
                'noice',
                'notify',
                'lazy',
                'mason',
                'Trouble',
                'alpha',
                'dashboard',
                'neo-tree',
                'NvimTree',
                'fidget',
                'snacks_notif',
                'snacks_notif_history',
                'snacks_terminal',
                'snacks_win',
                'snacks_input',
                'snacks_picker_input',
                'snacks_picker_preview',
                'snacks_layout',
                'blink-cmp-menu',
                'blink-cmp-signature-help',
                'blink-cmp-documentation',
            },
        }
    end,
}

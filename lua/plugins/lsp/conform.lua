return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require('conform').setup({
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "black" },
                rust = { "rustfmt" },
                c = { "clang-format" },
                cpp = { "clang-format" },
                cmake = { "cmake-format" },
            },
        })

        vim.api.nvim_create_autocmd("BufWritePre", {
            pattern = "*",
            callback = function(args)
                require("conform").format({ bufnr = args.buf })
            end,
        })
    end
}

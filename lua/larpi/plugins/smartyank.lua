return {
    'ibhagwan/smartyank.nvim',
    event = 'VeryLazy',
    opts = {
        highlight = {
            enabled = true,
            timeout = 200,
        },
        clipboard = {
            enabled = false,
        },
        osc52 = {
            enabled = true,
            ssh_only = true,
            silent = false,
        },
    },
}

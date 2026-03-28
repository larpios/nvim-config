return {
    'folke/flash.nvim',
    event = 'VeryLazy',
    ---@type Flash.Config
    opts = {
        search = {
            mode = 'fuzzy',
            incremental = true,
        },
        jump = {
            history = true,
            nohlsearch = true,
            autojump = true, -- TODO: Remove it after testing
        },
        label = {
            uppercase = false,
        },
        modes = {
            char = {
                jump_labels = true,
                autohide = true,
                jump = {
                    autojump = true,
                },
            },
            treesitter = {
                search = {
                    incremental = true,
                },
            },
        },
    },
    -- stylua: ignore
    keys = {
        { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
        { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
        { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
        { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
        { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
}

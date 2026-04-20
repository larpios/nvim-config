return {
    'mrcjkb/rustaceanvim',
    version = '^9', -- Recommended
    init = function()
        vim.g.rustaceanvim = {
            server = {
                cmd = { 'rust-analyzer' },
                settings = {
                    ['rust-analyzer'] = {
                        files = {
                            -- Critical for Nix: Prevents RA from trying to index the entire /nix/store
                            watcher = 'client',
                        },
                        checkOnSave = true,
                        check = {
                            command = 'clippy',
                            features = 'all',
                        },
                    },
                },
            },
        }
    end,
    lazy = false, -- This plugin is already lazy
}

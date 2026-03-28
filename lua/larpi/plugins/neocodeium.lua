return {
    'monkoose/neocodeium',
    event = 'InsertEnter',
    opts = {},
    cmd = 'NeoCodeium',
    keys = {
        {
            '<A-f>',
            function()
                require('neocodeium').accept()
            end,
            mode = 'i',
        },
    },
}

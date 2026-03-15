return {
    {
        -- Sudo write/read
        'lambdalisue/vim-suda',
        keys = {
            { '<leader><leader>Sw', '<cmd>SudaWrite<cr>', mode = 'n', desc = 'Sudo Write' },
            { '<leader><leader>Sr', '<cmd>SudaRead<cr>', mode = 'n', desc = 'Sudo Read' },
        },
        cmd = { 'SudaWrite', 'SudaRead' },
        config = function()
            vim.g.suda_smart_edit = 1
        end,
    },
    {
        'MagicDuck/grug-far.nvim',
        cmd = { 'GrugFar', 'GrugFarWithin' },
        config = function()
            require('grug-far').setup({
                -- options, see Configuration section below
                -- there are no required options atm
                -- engine = 'ripgrep' is default, but 'astgrep' can be specified
            })
        end,
    },

    {
        -- Preview the definition of the word under the cursor
        'rmagatti/goto-preview',
        event = 'BufRead',
        opts = {
            default_mappings = true,
        },
    },
    {
        -- AutoSession takes advantage of Neovim's existing session management capabilities
        -- to provide seamless automatic session management.
        'rmagatti/auto-session',
        lazy = false,

        ---enables autocomplete for opts
        ---@module "auto-session"
        ---@type AutoSession.Config
        opts = {
            auto_restore = false,
            suppressed_dirs = { '~/', '~/Downloads', '/' },
            -- log_level = 'debug',
        },
        init = function()
            vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
        end,
    },
    {
        'stevearc/quicker.nvim',
        ft = 'qf',
        keys = {
            {
                '<leader>tq',
                function()
                    require('quicker').toggle()
                end,
                desc = 'Toggle quickfix',
            },
            {
                '<leader>tl',
                function()
                    require('quicker').toggle({ loclist = true })
                end,
                desc = 'Toggle loclist',
            },
        },
        config = function()
            local quicker = require('quicker')
            quicker.setup({
                keys = {
                    {
                        '>',
                        function()
                            quicker.expand({ before = 2, after = 2, add_to_existing = true })
                        end,
                        desc = 'Expand quickfix context',
                    },
                    {
                        '<',
                        function()
                            quicker.collapse()
                        end,
                        desc = 'Collapse quickfix context',
                    },
                },
            })
        end,
    },
    {
        -- Color picker utils
        'uga-rosa/ccc.nvim',
        cmd = {
            'CccConvert',
            'CccPick',
            'CccHighlighterDisable',
            'CccHighlighterEnable',
            'CccHighlighterToggle',
        },
        config = function()
            local ColorInput = require('ccc.input')
            local convert = require('ccc.utils.convert')

            local RgbHslCmykInput = setmetatable({
                name = 'RGB/HSL/CMYK',
                max = { 1, 1, 1, 360, 1, 1, 1, 1, 1, 1 },
                min = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
                delta = { 1 / 255, 1 / 255, 1 / 255, 1, 0.01, 0.01, 0.005, 0.005, 0.005, 0.005 },
                bar_name = { 'R', 'G', 'B', 'H', 'S', 'L', 'C', 'M', 'Y', 'K' },
            }, { __index = ColorInput })

            function RgbHslCmykInput.format(n, i)
                if i <= 3 then
                    -- RGB
                    n = n * 255
                elseif i == 5 or i == 6 then
                    -- S or L of HSL
                    n = n * 100
                elseif i >= 7 then
                    -- CMYK
                    return ('%5.1f%%'):format(math.floor(n * 200) / 2)
                end
                return ('%6d'):format(n)
            end

            function RgbHslCmykInput.from_rgb(RGB)
                local HSL = convert.rgb2hsl(RGB)
                local CMYK = convert.rgb2cmyk(RGB)
                local R, G, B = unpack(RGB)
                local H, S, L = unpack(HSL)
                local C, M, Y, K = unpack(CMYK)
                return { R, G, B, H, S, L, C, M, Y, K }
            end

            function RgbHslCmykInput.to_rgb(value)
                return { value[1], value[2], value[3] }
            end

            function RgbHslCmykInput:_set_rgb(RGB)
                self.value[1] = RGB[1]
                self.value[2] = RGB[2]
                self.value[3] = RGB[3]
            end

            function RgbHslCmykInput:_set_hsl(HSL)
                self.value[4] = HSL[1]
                self.value[5] = HSL[2]
                self.value[6] = HSL[3]
            end

            function RgbHslCmykInput:_set_cmyk(CMYK)
                self.value[7] = CMYK[1]
                self.value[8] = CMYK[2]
                self.value[9] = CMYK[3]
                self.value[10] = CMYK[4]
            end

            function RgbHslCmykInput:callback(index, new_value)
                self.value[index] = new_value
                local v = self.value
                if index <= 3 then
                    local RGB = { v[1], v[2], v[3] }
                    local HSL = convert.rgb2hsl(RGB)
                    local CMYK = convert.rgb2cmyk(RGB)
                    self:_set_hsl(HSL)
                    self:_set_cmyk(CMYK)
                elseif index <= 6 then
                    local HSL = { v[4], v[5], v[6] }
                    local RGB = convert.hsl2rgb(HSL)
                    local CMYK = convert.rgb2cmyk(RGB)
                    self:_set_rgb(RGB)
                    self:_set_cmyk(CMYK)
                else
                    local CMYK = { v[7], v[8], v[9], v[10] }
                    local RGB = convert.cmyk2rgb(CMYK)
                    local HSL = convert.rgb2hsl(RGB)
                    self:_set_rgb(RGB)
                    self:_set_hsl(HSL)
                end
            end

            require('ccc').setup({
                inputs = {
                    RgbHslCmykInput,
                },
            })
        end,
    },
    {
        -- Awesome Neovim plugin list
        'alex-popov-tech/store.nvim',
        dependencies = {
            'OXY2DEV/markview.nvim', -- optional, for pretty readme preview / help window
        },
        cmd = 'Store',
        keys = {
            { '<leader>ps', '<cmd>Store<cr>', desc = 'Open Plugin Store' },
        },
        opts = {
            telemetry = false,
        },
    },
}

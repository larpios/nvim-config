return {
    -- Preview the definition of the word under the cursor
    'rmagatti/goto-preview',
    keys = {
        {
            'gpd',
            function()
                require('goto-preview').goto_preview_definition()
            end,
            desc = '[Goto Preview] Definition',
        },
        {
            'gpt',
            function()
                require('goto-preview').goto_preview_type_definition()
            end,
            desc = '[Goto Preview] Type Definition',
        },
        {
            'gpi',
            function()
                require('goto-preview').goto_preview_implementation()
            end,
            desc = '[Goto Preview] Implementation',
        },
        {
            'gpD',
            function()
                require('goto-preview').goto_preview_declaration()
            end,
            desc = '[Goto Preview] Declaration',
        },
        {
            'gP',
            function()
                require('goto-preview').close_all_win()
            end,
            desc = '[Goto Preview] Close All',
        },
        {
            'gpr',
            function()
                require('goto-preview').goto_preview_references()
            end,
            desc = '[Goto Preview] References',
        },
    },
    opts = {
        default_mappings = false,
    },
}

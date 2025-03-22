return {
    {
        'CopilotC-Nvim/CopilotChat.nvim',
        cmd = {
            'CopilotChat',
            'CopilotChatOpen',
            'CopilotChatClose',
            'CopilotChatAgents',
            'CopilotChatCommit',
            'CopilotChatCommitStaged',
            'CopilotChatDebugInfo',
            'CopilotChatDocs',
            'CopilotChatExplain',
            'CopilotChatFix',
            'CopilotChatFixDiagnostic',
            'CopilotChatLoad',
            'CopilotChatModels',
            'CopilotChatOptimize',
            'CopilotChatReset',
            'CopilotChatReview',
            'CopilotChatSave',
            'CopilotChatStop',
            'CopilotChatTests',
            'CopilotChatToggle',
        },
        dependencies = {
            { 'zbirenbaum/copilot.lua' },
            { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
        },
        build = 'make tiktoken', -- Only on MacOS or Linux
        opts = {
            model = 'claude-3.7-sonnet-thought',
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
    -- {
    --     'github/copilot.vim',
    --     event = 'InsertEnter'
    -- },
    {
        'zbirenbaum/copilot.lua',
        event = 'InsertEnter',
        cmd = 'Copilot',
        config = function()
            require('custom.copilot-lua')
        end,
    },
}

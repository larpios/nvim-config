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
            'CopilotDebugInfo',
            'CopilotDocs',
            'CopilotExplain',
            'CopilotFix',
            'CopilotFixDiagnostic',
            'CopilotLoad',
            'CopilotModels',
            'CopilotOptimize',
            'CopilotReset',
            'CopilotReview',
            'CopilotSave',
            'CopilotStop',
            'CopilotTests',
            'CopilotToggle',
        },
        dependencies = {
            { 'zbirenbaum/copilot.lua' },
            { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
        },
        build = 'make tiktoken', -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
        -- See Commands section for default commands if you want to lazy load on them
    },
}

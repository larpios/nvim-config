return {
  -- 1. FREE cloud autocomplete (Codeium)
  {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
      local neocodeium = require("neocodeium")
      neocodeium.setup()
      vim.keymap.set("i", "<A-a>", neocodeium.accept)
    end,
  },
  -- 2. FREE local model chat/edit (Ollama + DeepSeek)
  {
    "David-Kunz/gen.nvim",
    event = "VeryLazy",
    opts = {
      model = "deepseek-coder-v2:lite",
      quit_map = "q",
      show_prompt = false,
      show_model = false,
    }
  },
  -- 3. Cursor Composer clone (local AI sidebar)
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false,
    opts = {
      provider = "ollama",
      -- FIXED: Changed 'vendors' to 'providers'
      providers = {
        ollama = {
          __inherited_from = "openai",
          api_key_name = "",
          endpoint = "http://127.0.0.1:11434/v1",
          model = "deepseek-coder-v2:lite",
        },
      },
      auto_set_keymaps = true,
      -- REMOVED: auto_suggestions_provider = "neocodeium" (not supported)
      mappings = {
        edit = "<C-e>",
        jump_next = "]a",
        jump_prev = "[a",
      }
    },
    build = "make",
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-treesitter/nvim-treesitter",
    }
  },
  -- 4. Your existing Copilot student (when approved)
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function() require("copilot").setup() end,
  },
}

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    version = "^20.0.0",
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
      "CodeCompanionCmd",
      "CodeCompanionCodeReview",
      "CodeCompanionCLI",
    },
    keys = {
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "AI Actions" },
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "Toggle Chat" },
      { "<leader>an", "<cmd>CodeCompanionChat<cr>", mode = { "n", "v" }, desc = "New Chat" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "v" }, desc = "Inline Prompt" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = { "n" }, desc = "Inline Prompt" },
      { "<leader>ar", "<cmd>CodeCompanionChat Add<cr>", mode = { "v" }, desc = "Add Selection to Chat" },
      { "<leader>ah", "<cmd>CodeCompanionHistory<cr>", mode = { "n" }, desc = "Chat History" },
      { "<leader>acv", "<cmd>CodeCompanionCodeReview<cr>", mode = { "n" }, desc = "Code Review" },
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          http = {
            mammouth = function()
              return require("codecompanion.adapters").extend("openai_compatible", {
                name = "mammouth",
                formatted_name = "Mammouth",
                env = {
                  url = "https://api.mammouth.ai",
                  api_key = "MAMMOUTH_API_KEY",
                  chat_url = "/v1/chat/completions",
                  models_endpoint = "/v1/models",
                },
                headers = {
                  ["Content-Type"] = "application/json",
                  Authorization = "Bearer ${api_key}",
                },
                schema = {
                  model = {
                    default = "claude-sonnet-4-5",
                  },
                },
              })
            end,
          },
        },
        interactions = {
          chat = {
            adapter = "opencode",
          },
          inline = {
            adapter = "mammouth",
          },
          cmd = {
            adapter = "mammouth",
          },
          background = {
            adapter = "mammouth",
          },
        },
        opts = {
          log_level = "ERROR",
        },
      })
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      file_types = { "markdown", "codecompanion" },
    },
  },
}

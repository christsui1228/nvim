return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      gemini_cli = function()
        return require("codecompanion.adapters").extend("gemini_cli", {
          -- Gemini CLI 会自动使用你本地的认证信息
        })
      end,
    },
    strategies = {
      chat = { adapter = "gemini_cli" },
      inline = { adapter = "gemini_cli" },
      cmd = { adapter = "gemini_cli" },
    },
  },
}

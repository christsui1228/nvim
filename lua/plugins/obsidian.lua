return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    opts = {
      legacy_commands = false,
      workspaces = {
        {
          name = "personal",
          path = "~/Vault",
        },
      },
    },
    keys = {
      { "<leader>oo", "<cmd>Obsidian toggle_checkbox<CR>", desc = "Obsidian toggle checkbox" },
    },
  },
}

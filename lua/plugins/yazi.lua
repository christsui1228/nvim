return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>y", "<cmd>Yazi<cr>", desc = "在当前文件打开 Yazi" },
    },
    opts = {
      open_for_directories = true, -- 取代原生的目录打开方式
    },
  },
}

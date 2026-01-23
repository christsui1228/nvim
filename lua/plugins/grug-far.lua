return {
  {
    "MagicDuck/grug-far.nvim",
    opts = {
      -- 覆盖 Grug FAR 的默认快捷键
      keymaps = {
        -- n 代表普通模式 (Normal Mode)
        -- 将 Sync (同步/执行替换) 绑定到 <leader>S
        syncLocations = { n = "<leader>S" },
      },
    },
  },
}

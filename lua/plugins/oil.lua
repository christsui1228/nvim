return {
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- 可选，用于显示图标
    config = function()
      require("oil").setup({
        -- 是否设置为默认文件管理器（替代 netrw）
        default_file_explorer = true,
        -- 窗口设置
        view_options = {
          -- 显示隐藏文件
          show_hidden = true,
        },
        -- 浮动窗口设置（实现你想要的 Zellij 悬浮感）
        float = {
          padding = 2,
          max_width = 0.8,
          max_height = 0.8,
          border = "rounded", -- 圆角边框更优雅
          win_options = {
            winblend = 0, -- 这里的透明度建议设为 0，防止与背景冲突
          },
        },
      })
    end,
    -- 设置快捷键
    keys = {
      -- 按 "-" 打开当前的目录（这是 oil 的经典操作）
      { "-", "<cmd>Oil<cr>", desc = "打开父级目录" },
      -- 按 "ALT + f" 弹出你想要的“悬浮”文件管理窗
      {
        "<A-f>",
        function()
          require("oil").open_float()
        end,
        desc = "悬浮文件管理",
      },
    },
  },
}

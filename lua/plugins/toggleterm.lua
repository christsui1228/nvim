return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    -- opts 里的内容会被自动传递给 require("toggleterm").setup()
    opts = {
      -- 设置为悬浮模式
      direction = "float",
      -- 指定使用 fish
      shell = "fish",
      float_opts = {
        -- 圆角边框，视觉效果更好
        border = "curved",
      },
      -- 快捷键设置：按下 Ctrl + \ 即可打开/关闭
      open_mapping = [[<c-\>]],
    },
  },
}

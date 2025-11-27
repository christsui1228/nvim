return {
  {
    "kristijanhusak/vim-dadbod-ui",
    init = function()
      -- 基础配置：使用图标
      vim.g.db_ui_use_nerd_fonts = 1

      -- 【核心修复】解决按 'S' 键冲突的问题
      -- 创建一个自动命令：只有当光标进入 DBUI 界面时，才生效
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dbui",
        callback = function()
          -- 将 <Leader>o (即空格+o) 映射为“查看数据”
          vim.keymap.set("n", "<Leader>o", function()
            vim.fn["db_ui#action#select_query"]()
          end, { buffer = true, desc = "DB: 查看数据 (Open Data)" })
        end,
      })
    end,
  },
}

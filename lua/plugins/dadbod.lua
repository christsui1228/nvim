return {
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
      vim.g.db_ui_show_database_icon = 1

      -- =========================================================
      --  核心功能：智能 Tab 切换 (解决 Buffer 混乱的终极方案)
      -- =========================================================
      local function toggle_db_tab()
        local is_db_tab = false
        -- 检查当前 Tab 是否已经有 DBUI 窗口
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          local buf = vim.api.nvim_win_get_buf(win)
          local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
          if ft == "dbui" then
            is_db_tab = true
            break
          end
        end

        if is_db_tab then
          -- 如果已经在数据库 Tab，切回上一个 Tab (回代码)
          vim.cmd("tabprevious")
        else
          -- 查找是否已经有打开的 DBUI Tab
          local found_existing_tab = false
          for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
              local buf = vim.api.nvim_win_get_buf(win)
              local ft = vim.api.nvim_get_option_value("filetype", { buf = buf })
              if ft == "dbui" then
                vim.api.nvim_set_current_tabpage(tab)
                found_existing_tab = true
                break
              end
            end
            if found_existing_tab then
              break
            end
          end

          -- 没找到就新建 Tab 打开
          if not found_existing_tab then
            vim.cmd("tabnew")
            vim.cmd("DBUI")
          end
        end
      end

      -- 绑定全局快捷键 <leader>db
      vim.keymap.set(
        "n",
        "<leader>db",
        toggle_db_tab,
        { noremap = true, silent = true, desc = "Toggle DB UI (Smart Tab)" }
      )

      -- =========================================================
      --  【修复版】<leader>o 查看数据
      -- =========================================================
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "dbui",
        callback = function()
          -- 核心修改：这里不再调用内部函数，而是直接映射到 'o' 键
          -- remap = true 表示让这个映射去触发 dbui 插件原本对 'o' 的定义
          vim.keymap.set("n", "<Leader>o", "o", { buffer = true, remap = true, desc = "DB: Open Data" })
        end,
      })
    end,
  },
}

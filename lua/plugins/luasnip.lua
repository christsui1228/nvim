return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local ls = require("luasnip")

      -- 1. 基础配置：开启实时更新 (对应你之前的 opts 内容)
      ls.config.set_config({
        update_events = "TextChanged,TextChangedI",
      })

      -- 2. 【核心修复】让 Dadbod UI 窗口关联 SQL Snippets
      ls.filetype_extend("dbui", { "sql" })

      -- 3. 加载自定义 Lua Snippets (你的本地主力)
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })

      -- --- 快捷键设置 ---
      -- Choice Node 切换：<C-l> 下一个，<C-h> 上一个
      vim.keymap.set({ "i", "s" }, "<C-l>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end, { desc = "LuaSnip: Next choice" })

      vim.keymap.set({ "i", "s" }, "<C-h>", function()
        if ls.choice_active() then
          ls.change_choice(-1)
        end
      end, { desc = "LuaSnip: Previous choice" })

      -- --- 自定义命令 ---
      -- 手动重新加载 Snippets：:LuaSnipReload
      vim.api.nvim_create_user_command("LuaSnipReload", function()
        require("luasnip.loaders.from_lua").load({
          paths = { vim.fn.stdpath("config") .. "/snippets" },
        })
        print("Snippets reloaded!")
      end, {})
    end,
  },
}

return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      -- 【核心】开启实时更新，否则 tablename 不会随你打字而变化
      opts.update_events = "TextChanged,TextChangedI"

      -- 加载你的本地逻辑脚本
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })

      -- 加载旧的 JSON 备份（如果有需要）
      require("luasnip.loaders.from_vscode").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })

      return opts
    end,
  },
}

return {
  {
    "L3MON4D3/LuaSnip",
    opts = function(_, opts)
      -- 【核心】开启实时更新：确保你的 pmodel/tablename 会随打字实时转换
      opts.update_events = "TextChanged,TextChangedI"

      -- 1. 只加载你的本地 Lua 逻辑脚本 (这是你现在的主力)
      require("luasnip.loaders.from_lua").lazy_load({
        paths = { vim.fn.stdpath("config") .. "/snippets" },
      })

      -- 2. 【已屏蔽】不再加载 JSON 备份
      -- 删掉或注释掉 require("luasnip.loaders.from_vscode").lazy_load(...)
      -- 这样就不会再出现改名后依然被识别的“鬼魂”片段了

      return opts
    end,
  },
}

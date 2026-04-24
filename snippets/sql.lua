local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node

-- 辅助函数：获取当前日期 (2026-01-23) [cite: 2026-01-23]
local function get_date()
  return os.date("%Y-%m-%d")
end

-- 辅助函数：节点镜像 (让输入的字段名在多处同步)
local function mirror(args)
  return args[1][1]
end

ls.add_snippets("sql", {
  -- ==========================================
  -- 1. 基础 CRUD (快速响应)
  -- ==========================================

  -- 快速查询
  s("sel", {
    t("SELECT * FROM "),
    i(1, "table_name"),
    t(" LIMIT "),
    i(2, "100"),
    t(";"),
  }),

  -- 条件查询
  s("selw", {
    t("SELECT * FROM "),
    i(1, "table_name"),
    t({ "", "WHERE " }),
    i(2, "condition"),
    t(";"),
  }),

  -- 排序 (可与 selw 等组合)
  s("ord", {
    t("ORDER BY "),
    i(1, "column"),
    t(" "),
    c(2, { t("ASC"), t("DESC") }),
  }),

  -- 限制行数
  s("lim", {
    t("LIMIT "),
    i(1, "100"),
  }),
})

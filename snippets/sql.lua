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

  -- 精确条件查询
  s("selw", {
    t("SELECT * FROM "),
    i(1, "table_name"),
    t({ "", "WHERE " }),
    i(2, "column"),
    t(" = '"),
    i(3, "value"),
    t("';"),
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

  -- 删除
  s("del", {
    t("DELETE FROM "),
    i(1, "table_name"),
    t({ "", "WHERE " }),
    i(2, "condition"),
    t(";"),
  }),

  -- JOIN 查询
  s("selj", {
    t("SELECT * FROM "),
    i(1, "table_a"),
    t({ "", "JOIN " }),
    i(2, "table_b"),
    t({ " ON " }),
    i(3, "table_a.id = table_b.id"),
    t(";"),
  }),

  -- 更新
  s("upd", {
    t("UPDATE "),
    i(1, "table_name"),
    t({ "", "SET " }),
    i(2, "column = value"),
    t({ "", "WHERE " }),
    i(3, "condition"),
    t(";"),
  }),

  -- 插入
  s("ins", {
    t("INSERT INTO "),
    i(1, "table_name"),
    t(" ("),
    i(2, "col1, col2"),
    t({ ") VALUES (", "" }),
    i(3, "val1, val2"),
    t(");"),
  }),

  -- 计数
  s("cnt", {
    t("SELECT COUNT(*) FROM "),
    i(1, "table_name"),
    t(";"),
  }),

  -- 模糊条件
  s("like", {
    t("WHERE "),
    i(1, "column"),
    t(" LIKE '%"),
    i(2, "keyword"),
    t("%'"),
  }),

  -- 多条件 WHERE 1=1
  s("and", {
    t("WHERE 1=1"),
    t({ "", "  AND " }),
    i(1, "column"),
    t(" = '"),
    i(2, "value"),
    t("'"),
    t({ "", "  AND " }),
    i(3, "column"),
    t(" LIKE '%"),
    i(4, "value"),
    t("%'"),
  }),

  -- 查询今天时间段的数据
  s("selt", {
    t("SELECT * FROM "),
    i(1, "table_name"),
    t({ "", "WHERE " }),
    i(2, "created_at"),
    t(" >= '"),
    f(get_date, {}),
    t(" 00:00:00'"),
    t({ "", "  AND " }),
    f(mirror, { 2 }),
    t(" < '"),
    f(get_date, {}),
    t(" 23:59:59'"),
    t(";"),
  }),
})

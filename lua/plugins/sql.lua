local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("sql", {
  -- 快速查询 (sel)
  s("sel", {
    t("SELECT * FROM "),
    i(1, "table_name"),
    t(" LIMIT "),
    i(2, "100"),
    t(";"),
  }),

  -- 计数 (count)
  s("count", {
    t("SELECT count(*) FROM "),
    i(1, "table_name"),
    t(";"),
  }),

  -- 条件查询 (selw)
  s("selw", {
    t("SELECT * FROM "),
    i(1, "table_name"),
    t({ "", "WHERE " }),
    i(2, "condition"),
    t(";"),
  }),

  -- 更新数据 (upd)
  s("upd", {
    t("UPDATE "),
    i(1, "table_name"),
    t({ "", "SET " }),
    i(2, "column"),
    t(" = "),
    i(3, "value"),
    t({ "", "WHERE " }),
    i(4, "condition"),
    t(";"),
  }),

  -- 删除数据 (del)
  s("del", {
    t("DELETE FROM "),
    i(1, "table_name"),
    t({ "", "WHERE " }),
    i(2, "condition"),
    t(";"),
  }),

  -- 插入数据 (ins)
  s("ins", {
    t("INSERT INTO "),
    i(1, "table_name"),
    t(" ("),
    i(2, "columns"),
    t(")"),
    t({ "", "VALUES (" }),
    i(3, "values"),
    t(");"),
  }),

  -- 排序 (ord)
  s("ord", {
    t("ORDER BY "),
    i(1, "column_name"),
    t(" DESC"),
  }),

  -- 分组 (grp)
  s("grp", {
    t("GROUP BY "),
    i(1, "column_name"),
  }),
})

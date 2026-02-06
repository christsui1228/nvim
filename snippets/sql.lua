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

  -- 统计数量
  s("cnt", {
    t("SELECT COUNT(*) FROM "),
    i(1, "table_name"),
    t(";"),
  }),

  -- 降序查询
  s("seld", {
    t("SELECT * FROM "),
    i(1, "table_name"),
    t({ "", "ORDER BY " }),
    i(2, "column"),
    t(" DESC LIMIT "),
    i(3, "100"),
    t(";"),
  }),

  -- 升序查询
  s("sela", {
    t("SELECT * FROM "),
    i(1, "table_name"),
    t({ "", "ORDER BY " }),
    i(2, "column"),
    t(" ASC LIMIT "),
    i(3, "100"),
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

  -- 清空表
  s("trunc", {
    t("TRUNCATE TABLE "),
    i(1, "table_name"),
    t(" CASCADE;"),
  }),

  -- 插入记录
  s("ins", {
    t("INSERT INTO "),
    i(1, "table_name"),
    t(" ("),
    i(2, "column1"),
    t(", "),
    i(3, "column2"),
    t(")"),
    t({ "", "VALUES ('" }),
    i(4, "value1"),
    t("', '"),
    i(5, "value2"),
    t("');"),
  }),

  -- ==========================================
  -- 2. Lua 动态能力 (JSON 无法实现的威力)
  -- ==========================================

  -- 智能日期查询：自动填入今天，省去查日历的时间 [cite: 2026-01-23]
  s("selt", {
    t("SELECT * FROM "),
    i(1, "table_name"),
    t(" WHERE created_at >= '"),
    f(get_date),
    t("'"),
    t({ "", "ORDER BY created_at DESC LIMIT 100;" }),
  }),

  -- ==========================================
  -- 3. 复杂分析 (针对 Pareto/RFM 经验的复用)
  -- ==========================================

  -- 帕累托分析 (Pareto)：输入一次字段名，多处自动同步
  s("pareto", {
    t({ "WITH data AS (", "    SELECT " }),
    i(1, "category"),
    t(", SUM("),
    i(2, "value"),
    t(") as val"),
    t({ "", "    FROM " }),
    i(3, "table_name"),
    t({ "", "    GROUP BY 1", "),", "total AS (SELECT SUM(val) as t_val FROM data)" }),
    t({ "", "SELECT ", "    *,", "    SUM(val) OVER (ORDER BY val DESC) / t_val as cumulative_pct" }),
    t({ "", "FROM data, total", "ORDER BY val DESC;" }),
  }),
})

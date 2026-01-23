local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- 1. 核心转换逻辑：PascalCase -> snake_case
local function to_snake_case(args)
  local str = args[1][1] or ""
  if str == "" or str == "ClassName" then
    return "table_name"
  end
  -- 逻辑：在大写字母前加下划线，去掉开头下划线，转小写
  return str:gsub("(%u)", "_%1"):gsub("^_", ""):lower()
end

-- 2. 辅助逻辑：field_name -> Field Name (用于 help_text)
local function to_title_case(args)
  local str = args[1][1] or ""
  if str == "" then
    return ""
  end
  return str:gsub("_", " "):gsub("(%a)([%w]*)", function(first, rest)
    return first:upper() .. rest:lower()
  end)
end

ls.add_snippets("python", {
  -- Piccolo Model 模板
  s("pmodel", {
    t("class "),
    i(1, "ClassName"),
    t("(Table):"),
    t({ "", "    id = Serial(primary_key=True)", "    " }),
    i(2, "# TODO: Add fields"),
    t({ "", "", "    class Meta:", '        tablename = "' }),
    f(to_snake_case, { 1 }), -- 实时监听节点 1 (ClassName)
    t({ '"', "" }),
    i(0),
  }),

  -- 增强版 Varchar
  s("pv", {
    i(1, "field_name"),
    t(" = Varchar(length="),
    i(2, "50"),
    t(', help_text="'),
    f(to_title_case, { 1 }), -- 实时同步字段名
    t('")'),
    i(0),
  }),

  -- 增强版 ForeignKey
  s("pfk", {
    i(1, "field_name"),
    t(" = ForeignKey(references="),
    i(2, "TargetTable"),
    t(", null=True)"),
    i(0),
  }),
})

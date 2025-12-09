return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    -- 这是一个很常用的 Snippet 引擎，LazyVim 默认都有。
    -- 如果你没有用 luasnip，可以把下面用到 luasnip 的几行删掉。
    local luasnip = require("luasnip")

    opts.mapping = opts.mapping or {}

    -- 1. 【保留你原有的回车逻辑】
    -- 只有当菜单可见且有选中项时，才确认；否则交给 fallback (mini.pairs)
    opts.mapping["<CR>"] = cmp.mapping(function(fallback)
      if cmp.visible() and cmp.get_active_entry() then
        cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
      else
        fallback()
      end
    end, { "i", "s" })

    -- 2. 【新增：修复 Tab 键逻辑】
    -- 这里的逻辑是：菜单出来时 -> 选下一个；没菜单时 -> 可能是跳转代码片段；否则 -> 输入原始Tab
    opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item() -- 👈 这里解决了你的问题：不再是输入空格，而是向下选择
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump() -- 支持跳到下一个参数位置
      else
        fallback() -- 既没菜单也没 snippet，才输入空格
      end
    end, { "i", "s" })

    -- 3. 【新增：Shift + Tab 向上选择】
    opts.mapping["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" })
  end,
}

return {
  "hrsh7th/nvim-cmp",
  -- 确保这里没有 "Exafunction/codeium.nvim" 的依赖，因为我们用的是 vim 版
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-path", -- 推荐加上路径补全
  },

  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    local cmp = require("cmp")
    local luasnip = require("luasnip")

    -- 1. 净化源：确保下拉菜单里只有 LSP、代码片段和路径，没有 Codeium
    opts.sources = cmp.config.sources({
      { name = "nvim_lsp", priority = 100 },
      { name = "luasnip", priority = 90 },
      { name = "path", priority = 80 },
    })

    -- 2. 修复按键映射
    opts.mapping = vim.tbl_deep_extend("force", opts.mapping or {}, {

      -- 【Tab】菜单出现则下移，否则尝试跳转片段，最后才输入 Tab
      ["<Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        else
          fallback()
        end
      end, { "i", "s" }),

      -- 【Shift+Tab】上移
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),

      -- 【Enter (回车) 终极修复版】
      -- 逻辑：如果菜单开着，并且你【手动选中】了某一项，回车才确认。
      -- 否则（菜单没开，或者菜单开着但你没按上下键），回车就是换行。
      ["<CR>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
          else
            fallback() -- 这里确保了平时按回车能正常换行
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
      }),
    })
  end,
}

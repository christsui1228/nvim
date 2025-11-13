-- ~/.config/nvim/lua/plugins/codeium.lua
-- 最终的、已修复“回车键(Enter)”冲突的版本

return {
  -- 1. Codeium 插件本身
  {
    "Exafunction/codeium.nvim",
    dependencies = { "hrsh7th/nvim-cmp" },
    event = "InsertEnter",
    opts = {},
  },

  -- 2. nvim-cmp (自动补全引擎) 的配置
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    event = "InsertEnter",

    dependencies = {
      "Exafunction/codeium.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },

    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.sources = {
        { name = "codeium", priority = 80 },
        { name = "nvim_lsp", priority = 100 },
        { name = "luasnip", priority = 90 },
      }

      opts.snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      }

      -- C. 配置按键绑定
      opts.mapping = cmp.mapping.preset.insert({

        -- (1) 菜单导航
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = "select" }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
        ["<Down>"] = cmp.mapping.select_next_item({ behavior = "select" }),
        ["<Up>"] = cmp.mapping.select_prev_item({ behavior = "select" }),

        -- (2) 接受补全 (Tab 键)
        ["<Tab>"] = cmp.mapping.confirm({ select = true }),

        -- (3) !! 关键修复：智能的回车键 !!
        ["<CR>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            -- 如果菜单可见，就接受选中的建议
            cmp.confirm({ select = true })
          else
            -- 否则，执行默认的回车操作 (插入新行)
            fallback()
          end
        end, { "i", "s" }),

        -- (4) 片段跳转
        ["<C-j>"] = cmp.mapping(function(fallback)
          if require("luasnip").jumpable(1) then
            require("luasnip").jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<C-k>"] = cmp.mapping(function(fallback)
          if require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      })

      return opts
    end,
  },
}

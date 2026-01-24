return {
  "saghen/blink.cmp",
  opts = {
    keymap = {
      preset = "default",
      -- 【核心修复】直接使用字符串列表，blink 会按顺序尝试：
      -- 1. 如果有片段，跳到下一个点
      -- 2. 如果有菜单，选下一项
      -- 3. 否则执行默认 Tab 功能
      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

      -- 确认键：接受补全
      ["<CR>"] = { "accept", "fallback" },
    },

    -- 保持之前的引擎和来源配置
    snippets = { preset = "luasnip" },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
      providers = {
        snippets = {
          score_offset = 10, -- 提升 snippets 优先级
        },
        buffer = {
          score_offset = -3, -- 降低 buffer 优先级
        },
      },
    },
  },
}

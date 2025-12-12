return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function()
    -- 1. 禁用 Codeium 自带的按键 (防止抢 Tab)
    vim.g.codeium_disable_bindings = 1

    -- 2. 设置 Ghost Text 快捷键
    -- Ctrl + g : 接受建议 (Accept)
    vim.keymap.set("i", "<C-f>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, silent = true })

    -- Ctrl + ; : 下一个建议
    vim.keymap.set("i", "<C-;>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true, silent = true })

    -- Ctrl + , : 上一个建议
    vim.keymap.set("i", "<C-,>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true, silent = true })

    -- Ctrl + x : 清除建议
    vim.keymap.set("i", "<C-x>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true, silent = true })
  end,
}

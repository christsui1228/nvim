return {
  "kndndrj/nvim-dbee",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  -- 只有在执行 :Dbee 命令或按下快捷键时才加载
  cmd = "Dbee",
  build = function()
    require("dbee").install()
  end,
  keys = {
    { "<leader>dd", "<cmd>Dbee<cr>", desc = "Dbee" },
  },
  config = function()
    local dbee = require("dbee")
    local sources = require("dbee.sources")

    dbee.setup({
      sources = {
        -- 1. 自动环境变量源 (可选)
        sources.EnvSource:new("DBEE_CONNECTIONS"),

        -- 2. 核心：指定本地 JSON 保存路径
        -- 使用 stdpath("state") 会将文件保存在 ~/.local/state/nvim/dbee/persistence.json
        -- 这符合 Neovim 的最新规范，也能避免你截图中的那个迁移错误
        sources.FileSource:new(vim.fn.stdpath("state") .. "/dbee/persistence.json"),
      },
    })
  end,
}

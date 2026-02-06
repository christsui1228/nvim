-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- 开启自动读取文件变化
vim.opt.autoread = true
-- 设置全局默认 shell 为 fish
if vim.fn.executable("fish") == 1 then
  vim.opt.shell = "fish"
end

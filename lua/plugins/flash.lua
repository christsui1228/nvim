-- lua/plugins/flash.lua
return {
  "folke/flash.nvim",
  opts = {
    exclude = {
      "dbui",
      "dbout",
    },
  },
}

return {
  "numToStr/Comment.nvim",
  opts = function(_, opts)
    local ft = require "Comment.ft"
    ft.thrift = { "//%s", "/*%s*/" }
    ft.goctl = { "//%s", "/*%s*/" }
  end,
}

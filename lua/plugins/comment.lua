return {
  "numToStr/Comment.nvim",
  opts = function(_, opts)
    local ft = require "Comment.ft"
    ft.thrift = { "//%s", "/*%s*/" }
  end,
}

-- Jumping along the indents ([i, ]i)
-- Text object (dii, cai, yii, vai, etc.)
return {
  "arsham/indent-tools.nvim",
  dependencies = { "arsham/arshlib.nvim" },
  event = "User AstroFile",
  config = function() require("indent-tools").config {} end,
}

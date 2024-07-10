-- Jumping along the indents ([i, ]i)
-- Text object (dii, cai, yii, vai, etc.)

---@type LazySpec
return {
  "arsham/indent-tools.nvim",
  dependencies = { "arsham/arshlib.nvim", "nvim-treesitter/nvim-treesitter-textobjects" },
  event = "User AstroFile",
  config = true,
  keys = { "]i", "[i", { "v", "ii" }, { "o", "ii" } },
}

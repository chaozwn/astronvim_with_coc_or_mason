-- https://github.com/zbirenbaum/copilot-cmp
return {
  "zbirenbaum/copilot-cmp",
  event = "LspAttach",
  dependencies = { "copilot.lua", "nvim-cmp" },
  config = function()
    require("copilot_cmp").setup {
      method = "getCompletionsCycling",
      formatters = {
        label = require("copilot_cmp.format").format_label_text,
        insert_text = require("copilot_cmp.format").remove_existing,
        preview = require("copilot_cmp.format").deindent,
      },
    }
  end,
}

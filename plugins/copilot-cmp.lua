local has_words_before = function()
  if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then return false end
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match "^%s*$" == nil
end
-- https://github.com/zbirenbaum/copilot-cmp
return {
  "zbirenbaum/copilot-cmp",
  event = "LspAttach",
  dependencies = { "copilot.lua", "nvim-cmp" },
  config = function()
    local cmp = require "cmp"
    require("copilot_cmp").setup {
      method = "getCompletionsCycling",
      formatters = {
        label = require("copilot_cmp.format").format_label_text,
        insert_text = require("copilot_cmp.format").remove_existing,
        preview = require("copilot_cmp.format").deindent,
      },
      mapping = {
        ["<Tab>"] = vim.schedule_wrap(function(fallback)
          if cmp.visible() and has_words_before() then
            cmp.select_next_item { behavior = cmp.SelectBehavior.Select }
          else
            fallback()
          end
        end),
      },
    }
  end,
}

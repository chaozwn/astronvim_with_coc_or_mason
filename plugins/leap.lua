return {
  ----------------------- 移动插件 --------------------------------------
  {
    "ggandor/leap.nvim",
    config = function()
      local leap = require "leap"
      -- leap.init_highlight(true)
      leap.setup {
        highlight_unlabeled_phase_one_targets = false,
        max_phase_one_targets = nil,
        max_highlighted_traversal_targets = 10,
        case_sensitive = false,
        -- safe_labels = {},
        special_keys = {
          repeat_search = "<enter>",
          next_phase_one_target = "<enter>",
          next_target = { "<enter>", ";" },
          prev_target = { "<tab>", "," },
          next_group = "<space>",
          prev_group = "<tab>",
          multi_accept = "<enter>",
          multi_revert = "<backspace>",
        },
      }
    end,
    event = "User AstroFile",
  },
}

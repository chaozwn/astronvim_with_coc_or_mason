---@type LazySpec
return {
  "chaozwn/im-select.nvim",
  lazy = false,
  opts = {
    default_command = "macism",
    default_main_select = "com.sogou.inputmethod.sogou.pinyin",
    set_previous_events = { "InsertEnter", "FocusLost" },
  },
}

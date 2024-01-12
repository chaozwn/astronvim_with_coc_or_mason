return {
  "chaozwn/im-select.nvim",
  lazy = false,
  opts = {
    -- 该选项会进入插入模式使用的输入法fcitx 1 2顺序跟设置的顺序一致,禁用会记录插入模式使用的输入法，再次进入插入会切换到记录的输入法
    -- default_main_select = "1", 
    set_previous_events = { "InsertEnter", "FocusLost" },
    -- set_default_events = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },
  },
}


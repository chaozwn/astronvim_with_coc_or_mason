---@type LazySpec
return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "BufEnter",
  opts = {
    suggestion = {
      enabled = true,
      auto_trigger = true,
      debounce = 150,
      keymap = {
        accept = "<C-;>",
        accept_word = false,
        accept_line = false,
        next = "<M-]>",
        prev = "<M-[>",
        dismiss = "<C-]>",
      },
    },
  },
}

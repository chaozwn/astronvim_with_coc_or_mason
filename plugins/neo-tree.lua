local get_icon = require("astronvim.utils").get_icon
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    close_if_last_window = true,
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
        hide_by_name = {
          ".git",
        },
      },
    },
    source_selector = {
      sources = {
        filesystem = get_icon "FolderClosed" .. " File",
        buffers = get_icon "DefaultFile" .. " Bufs",
        git_status = get_icon "Git" .. " Git",
        diagnostics = get_icon "Diagnostic" .. " Diagnostic",
      },
    },
  },
}

local get_icon = require("astronvim.utils").get_icon

-- NOTE: https://github.com/adelarsq/image_preview.nvim wait alacriity pull request merge
-- NOTE: https://github.com/nvim-neo-tree/neo-tree.nvim/issues/860 wait undo modifications close
return {
  "nvim-neo-tree/neo-tree.nvim",
  -- dependencies = { "miversen33/netman.nvim" },
  opts = function(_, opts)
    return require("astronvim.utils").extend_tbl(opts, {
      close_if_last_window = true,
      enable_diagnostics = true,
      sources = {
        "filesystem",
        -- "netman.ui.neo-tree",
        -- "buffers",
        -- "git_status",
      },
      window = {
        width = 35,
      },
      source_selector = {
        winbar = false,
        sources = {
          { source = "filesystem", display_name = get_icon("FolderClosed", 1, true) .. "File" },
          -- { source = "buffers", display_name = get_icon("DefaultFile", 1, true) .. "Bufs" },
          -- { source = "git_status", display_name = get_icon("Git", 1, true) .. "Git" },
          -- { source = "remote", display_name = get_icon("Session", 1, true) .. "Remote" },
        },
      },
      filesystem = {
        -- hijack_netrw_behavior = "open_default",
        filtered_items = {
          always_show = { ".github", ".gitignore" },
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".git",
            -- "node_modules",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
      },
    })
  end,
}

---@type LazySpec
return {
  "nvim-neo-tree/neo-tree.nvim",
  enabled = false,
  -- dependencies = { "miversen33/netman.nvim" },
  opts = function(_, opts)
    return require("astrocore").extend_tbl(opts, {
      close_if_last_window = true,
      enable_diagnostics = true,
      popup_border_style = "rounded",
      sources = {
        "filesystem",
      },
      source_selector = {
        winbar = false,
      },
      filesystem = {
        -- hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true,
        bind_to_cwd = false,
        follow_current_file = {
          enabled = true,
        },
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

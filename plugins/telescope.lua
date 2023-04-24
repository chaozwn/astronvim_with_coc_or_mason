return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    "ahmedkhalf/project.nvim", -- defined in  ./editor.lua
  },
  opts = function(_, opts)
    local actions = require "telescope.actions"
    local fb_actions = require("telescope").extensions.file_browser.actions
    return require("astronvim.utils").extend_tbl(opts, {
      defaults = {
        selection_caret = "  ",
        layout_config = {
          width = 0.90,
          height = 0.85,
          preview_cutoff = 120,
          horizontal = {
            preview_width = 0.6,
          },
          vertical = {
            width = 0.9,
            height = 0.95,
            preview_height = 0.5,
          },
          flex = {
            horizontal = {
              preview_width = 0.9,
            },
          },
        },
      },
      extensions = {
        file_browser = {
          mappings = {
            i = {
              ["<C-z>"] = fb_actions.toggle_hidden,
            },
            n = {
              z = fb_actions.toggle_hidden,
            },
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          path_display = { "smart" },
          mappings = {
            i = { ["<c-d>"] = actions.delete_buffer },
            n = { ["d"] = actions.delete_buffer },
          },
        },
      },
    })
  end,
  config = function(...)
    require "plugins.configs.telescope"(...)
    local telescope = require "telescope"
    telescope.load_extension "file_browser"
    telescope.load_extension "projects"
  end,
}

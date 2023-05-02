return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    "ahmedkhalf/project.nvim", -- defined in  ./editor.lua
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
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
              -- Create file/folder at current path (trailing path separator creates folder)
              ["A-a"] = fb_actions.create,
              -- Rename multi-selected files/folders
              ["A-r"] = fb_actions.rename,
              -- Move multi-selected files/folders to current path
              ["A-m"] = fb_actions.move,
              -- Copy (multi-)selected files/folders to current path
              ["A-y"] = fb_actions.copy,
              -- Delete (multi-)selected files/folders
              ["A-d"] = fb_actions.remove,
              -- Open file/folder with default system application
              ["C-t"] = fb_actions.open,
              -- Go to parent directory
              ["C-g"] = fb_actions.goto_parent_dir,
              -- Go to home directory
              ["C-e"] = fb_actions.goto_home_dir,
              -- Go to current working directory (cwd)
              ["C-w"] = fb_actions.goto_cwd,
              -- Change nvim's cwd to selected folder/file(parent)
              ["C-o"] = fb_actions.change_cwd,
              -- Toggle between file and folder browser
              ["C-f"] = fb_actions.toggle_browser,
              -- Toggle hidden files/folders
              ["C-h"] = fb_actions.toggle_hidden,
              -- Toggle all entries ignoring ./ and ../
              ["C-s"] = fb_actions.toggle_all,
              ["<bs>"] = fb_actions.backspace,
            },
            n = {
              ["a"] = fb_actions.create,
              ["r"] = fb_actions.rename,
              ["m"] = fb_actions.move,
              ["y"] = fb_actions.copy,
              ["d"] = fb_actions.remove,
              ["t"] = fb_actions.open,
              ["g"] = fb_actions.goto_parent_dir,
              ["e"] = fb_actions.goto_home_dir,
              ["w"] = fb_actions.goto_cwd,
              ["o"] = fb_actions.change_cwd,
              ["f"] = fb_actions.toggle_browser,
              ["h"] = fb_actions.toggle_hidden,
              ["s"] = fb_actions.toggle_all,
              ["<bs>"] = fb_actions.backspace,
            },
          },
        },
        -- Chafa (required for image support) 正常情况下装一个这个就可以了
        -- ImageMagick (optional, for svg previews)
        -- fd / rg / find or fdfind in Ubuntu/Debian.
        -- ffmpegthumbnailer (optional, for video preview support)
        -- pdftoppm (optional, for pdf preview support. Available in the AUR as poppler package.)
        -- epub-thumbnailer (optional, for epub preview support.)
        -- fontpreview (optional, for font preview support)
        media_files = {
          filetypes = { "png", "jpg", "gif", "mp4", "webm", "pdf", "svg" },
          find_cmd = "rg",
        },
      },
      pickers = {
        find_files = {
          -- dot file
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
    require "plugins.configs.telescope" (...)
    local telescope = require "telescope"
    telescope.load_extension "file_browser"
    telescope.load_extension "projects"
    telescope.load_extension "media_files"
  end,
}

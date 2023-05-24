return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "ahmedkhalf/project.nvim", -- defined in  ./editor.lua
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
  },
  opts = function(_, opts)
    local actions = require "telescope.actions"
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
    local lsp_type = require("user.config.lsp_type").lsp_type

    require "plugins.configs.telescope" (...)
    local telescope = require "telescope"
    telescope.load_extension "projects"
    telescope.load_extension "media_files"
    if lsp_type ~= 'coc' then
      telescope.load_extension "refactoring"
    end
  end,
}

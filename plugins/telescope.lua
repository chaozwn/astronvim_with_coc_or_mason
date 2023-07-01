return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "ahmedkhalf/project.nvim", -- defined in  ./editor.lua
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    "fannheyward/telescope-coc.nvim",
  },
  opts = function(_, opts)
    local actions = require "telescope.actions"
    return require("astronvim.utils").extend_tbl(opts, {
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
        coc = {
          -- theme = "dropdown",
          initial_mode = "normal",
          prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
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
    -- TODO: add telescope dap ui https://github.com/nvim-telescope/telescope-dap.nvim
    require "plugins.configs.telescope"(...)
    local telescope = require "telescope"
    telescope.load_extension "projects"
    if vim.g.lsp_type ~= "coc" then
      telescope.load_extension "refactoring"
    else
      telescope.load_extension "coc"
    end
  end,
}

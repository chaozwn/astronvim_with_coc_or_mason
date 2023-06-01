return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "ahmedkhalf/project.nvim", -- defined in  ./editor.lua
    "nvim-telescope/telescope-media-files.nvim",
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
    'fannheyward/telescope-coc.nvim'
  },
  opts = function(_, opts)
    local actions = require "telescope.actions"
    return require("astronvim.utils").extend_tbl(opts, {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "-L",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
        prompt_prefix = "   ",
        selection_caret = "  ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
            results_width = 0.8,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
        file_sorter = require("telescope.sorters").get_fuzzy_file,
        file_ignore_patterns = { "node_modules" },
        generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
        path_display = { "truncate" },
        winblend = 0,
        border = {},
        borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        color_devicons = true,
        set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
        file_previewer = require("telescope.previewers").vim_buffer_cat.new,
        grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
        qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
        mappings = {
          n = { ["q"] = require("telescope.actions").close },
        },
      },
      extensions_list = { "themes", "terms" },
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
          theme = "dropdown",
          initial_mode = "normal",
          prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
        }
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
    -- TODO: add telescope dap ui https://github.com/nvim-telescope/telescope-dap.nvim

    require "plugins.configs.telescope" (...)
    local telescope = require "telescope"
    telescope.load_extension "projects"
    telescope.load_extension "media_files"
    if lsp_type ~= 'coc' then
      telescope.load_extension "refactoring"
    else
      telescope.load_extension "coc"
    end
  end,
}

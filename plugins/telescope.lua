return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/popup.nvim",
    "nvim-lua/plenary.nvim",
  },
  opts = function(_, opts)
    local actions = require "telescope.actions"
    return require("astronvim.utils").extend_tbl(opts, {
      extensions = {},
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
    telescope.load_extension "refactoring"
    telescope.load_extension "noice"
  end,
}

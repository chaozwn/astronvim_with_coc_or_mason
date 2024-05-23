local utils = require "utils"
---@type LazySpec
return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  keys = {
    -- 👇 in this section, choose your own keymappings!
    {
      "<leader>ty",
      function() require("yazi").yazi() end,
      desc = "Open the file manager",
    },
    {
      -- Open in the current working directory
      "<leader>tY",
      function() require("yazi").yazi(nil, vim.fn.getcwd()) end,
      desc = "Open the file manager in nvim's working directory",
    },
  },
  ---@type YaziConfig
  opts = {
    open_for_directories = false,
    hooks = {
      yazi_opened = function()
        utils.remove_keymap("t", "<C-H>")
        utils.remove_keymap("t", "<C-J>")
        utils.remove_keymap("t", "<C-K>")
        utils.remove_keymap("t", "<C-L>")
      end,
      yazi_closed_successfully = function()
        vim.api.nvim_set_keymap("t", "<C-h>", "<cmd>wincmd h<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-j>", "<cmd>wincmd j<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-k>", "<cmd>wincmd k<cr>", { silent = true, noremap = true })
        vim.api.nvim_set_keymap("t", "<C-l>", "<cmd>wincmd l<cr>", { silent = true, noremap = true })
      end,
    },
  },
}

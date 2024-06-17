return {
  {
    "benlubas/molten-nvim",
    dependencies = {
      {
        "willothy/wezterm.nvim",
        config = true,
      },
    },
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "wezterm"
      vim.g.molten_use_border_highlights = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = false
      vim.g.molten_virt_lines_off_by_1 = false
      vim.g.molten_auto_open_output = false
      vim.g.molten_auto_open_html_in_browser = true
      vim.g.molten_open_cmd = 'open'

      -- don't change the mappings (unless it's related to your bug)
      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>")
      vim.keymap.set("n", "<localleader>me", ":MoltenEvaluateOperator<CR>")
      vim.keymap.set("n", "<localleader>mr", ":MoltenReevaluateCell<CR>")
      vim.keymap.set("v", "<localleader>mr", ":<C-u>MoltenEvaluateVisual<CR>gv")
      vim.keymap.set("n", "<localleader>ms", ":noautocmd MoltenEnterOutput<CR>")
      vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>")
      vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>")
    end,
  },
}

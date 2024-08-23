local system = vim.loop.os_uname().sysname

if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Mono:h16"
  vim.g.neovide_no_idle = true
  vim.g.neovide_confirm_quit = true
  vim.g.neovide_fullscreen = false
  vim.g.neovide_remember_window_size = true
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  vim.g.neovide_cursor_vfx_mode = "railgun"

  if system == "Darwin" then
    vim.g.neovide_input_use_logo = 1 -- enable use of the logo (cmd) key

    vim.api.nvim_set_keymap("", "<D-c>", '"+y', { noremap = true, silent = true })
    -- Allow clipboard copy paste in neovim
    vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })
  end
end

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  { import = "astrocommunity.recipes.neovide" },
  { import = "astrocommunity.recipes.vscode-icons" },
  { import = "astrocommunity.keybinding.nvcheatsheet-nvim" },
  {
    "AstroNvim/astrocore",
    opts = {
      mappings = {
        n = {
          ["<F1>"] = false,
          ["<F2>"] = {
            function()
              vim.cmd.Neotree "close"
              require("nvcheatsheet").toggle()
            end,
            desc = "Cheatsheet",
          },
        },
      },
    },
  },
}

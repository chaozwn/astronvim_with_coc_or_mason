---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.recipes.astrolsp-no-insert-inlay-hints" },
  { import = "astrocommunity.lsp.nvim-lsp-file-operations" },
  { import = "astrocommunity.recipes.auto-session-restore" },
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
  -- { import = "astrocommunity.workflow.hardtime-nvim" },
}

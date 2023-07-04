return {
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.auto-save-nvim" },
  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity.editing-support.zen-mode-nvim" },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        options = {
          number = true,
          relativenumber = true,
          signcolumn = "yes",
          foldcolumn = "1",
          list = true, -- show whitespace characters
        },
      },
      on_open = function() -- disable diagnostics and indent blankline
        vim.g.diagnostics_mode_old = vim.g.diagnostics_mode
        vim.b.miniindentscope_disable_old = vim.b.miniindentscope_disable
        vim.g.winbar_old = vim.wo.winbar
        vim.g.diagnostics_mode = 0
        vim.diagnostic.config(require("astronvim.utils.lsp").diagnostics[0])
        -- vim.g.indent_blankline_enabled_old = vim.g.indent_blankline_enabled
        -- vim.g.indent_blankline_enabled = false
        vim.wo.winbar = nil
        vim.b.miniindentscope_disable = true
      end,
      on_close = function() -- restore diagnostics and indent blankline
        vim.g.diagnostics_mode = vim.g.diagnostics_mode_old
        vim.diagnostic.config(require("astronvim.utils.lsp").diagnostics[vim.g.diagnostics_mode])
        vim.wo.winbar = vim.g.winbar_old
        vim.b.miniindentscope_disable = vim.b.miniindentscope_disable_old
        -- vim.g.indent_blankline_enabled = vim.g.indent_blankline_enabled_old
      end,
    },
  },
}

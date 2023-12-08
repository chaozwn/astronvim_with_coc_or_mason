return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      -- Customize or remove this keymap to your liking
      "<leader>lc",
      function()
        print "Formatting..."
        require("conform").format { async = true, lsp_fallback = true }
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  -- Everything in opts will be passed to setup()
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { { "prettierd", "prettier" } },
      astro = { { "prettierd", "prettier" } },
      -- astro = { { "eslint_d" } },
    },
    -- Set up format-on-save
    format_on_save = { timeout_ms = 5000, lsp_fallback = true },
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
-- return {
--   "stevearc/conform.nvim",
--   lazy = true,
--   event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
--   config = function()
--     local conform = require "conform"
--
--     conform.setup {
--       formatters_by_ft = {
--         javascript = { "prettier" },
--         typescript = { "prettier" },
--         javascriptreact = { "prettier" },
--         typescriptreact = { "prettier" },
--         svelte = { "prettier" },
--         css = { "prettier" },
--         html = { "prettier" },
--         json = { "prettier" },
--         yaml = { "prettier" },
--         markdown = { "prettier" },
--         graphql = { "prettier" },
--         lua = { "stylua" },
--         astro = { { "prettier" } },
--         python = { "isort", "black" },
--       },
--       format_on_save = {
--         lsp_fallback = true,
--         async = false,
--         timeout_ms = 2000,
--       },
--     }
--
--     vim.keymap.set(
--       { "n", "v" },
--       "<leader>lc",
--       function()
--         conform.format {
--           lsp_fallback = true,
--           async = false,
--           timeout_ms = 2000,
--         }
--       end,
--       { desc = "Format file or range (in visual mode)" }
--     )
--   end,
-- }

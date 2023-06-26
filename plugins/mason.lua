-- :e 重新加载语言分析服务
-- :LSPInstall lua_ls
-- customize mason plugins
local getEvent = function()
  if vim.g.lsp_type == "coc" then
    return "User AstroFile"
  else
    return "LspAttach"
  end
end

return {
  {
    -- This is needed for pylint to work in a virtualenv. See https://github.com/williamboman/mason.nvim/issues/668#issuecomment-1320859097
    "williamboman/mason.nvim",
  },
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
  },
  -- :NullLSInstall stylua
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
  },
  -- :DapInstall python
  {
    "jay-babu/mason-nvim-dap.nvim",
  },
  {
    "Weissle/persistent-breakpoints.nvim",
    event = "BufReadPost",
    opts = function(_, opts)
      return require("astronvim.utils").extend_tbl(opts, {
        load_breakpoints_event = { "BufReadPost" },
      })
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function()
      require("lsp_signature").setup {
        noice = true,
        hint_prefix = " ",
      }
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
    event = getEvent(),
    opts = {
      commented = true,
      enabled = true, -- enable this plugin (the default)
      enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    },
  },
  {
    "ThePrimeagen/refactoring.nvim",
    event = "LspAttach",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function() require("refactoring").setup {} end,
  },
}

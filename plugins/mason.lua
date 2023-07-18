-- :e 重新加载语言分析服务
-- :LSPInstall lua_ls
-- customize mason plugins
local user_utils = require "user.utils.utils"
local utils = require "astronvim.utils"
return {
  {
    -- This is needed for pylint to work in a virtualenv. See https://github.com/williamboman/mason.nvim/issues/668#issuecomment-1320859097
    "williamboman/mason.nvim",
  },
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, { "emmet_language_server" })
      -- opts.ensure_installed = user_utils.list_remove_unique(opts.ensure_installed, { "emmet_ls" })
    end,
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
}

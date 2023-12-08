-- :e 重新加载语言分析服务
-- :LSPInstall lua_ls
-- customize mason plugins
local user_utils = require "user.utils.utils"
local utils = require "astronvim.utils"
return {
  {
    -- This is needed for pylint to work in a virtualenv. See https://github.com/williamboman/mason.nvim/issues/668#issuecomment-1320859097
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
  },
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      -- NOTE: https://github.com/antonk52/cssmodules-language-server
      opts.ensure_installed =
        utils.list_insert_unique(opts.ensure_installed, { "cssmodules_ls", "emmet_language_server" })
      opts.ensure_installed = user_utils.list_remove_unique(opts.ensure_installed, { "emmet_ls" })
    end,
  },
  -- :DapInstall python
  {
    "jay-babu/mason-nvim-dap.nvim",
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function(_, opts)
      local dap, dapui = require "dap", require "dapui"
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dapui.setup(opts)
    end,
  },
}
-- return {
--   "williamboman/mason.nvim",
--   dependencies = {
--     "williamboman/mason-lspconfig.nvim",
--     "WhoIsSethDaniel/mason-tool-installer.nvim",
--   },
--   config = function()
--     -- import mason
--     local mason = require "mason"
--
--     -- import mason-lspconfig
--     local mason_lspconfig = require "mason-lspconfig"
--
--     local mason_tool_installer = require "mason-tool-installer"
--
--     -- enable mason and configure icons
--     mason.setup {
--       ui = {
--         icons = {
--           package_installed = "✓",
--           package_pending = "➜",
--           package_uninstalled = "✗",
--         },
--       },
--     }
--
--     mason_lspconfig.setup {
--       -- list of servers for mason to install
--       ensure_installed = {
--         "tsserver",
--         "html",
--         "cssls",
--         "tailwindcss",
--         "svelte",
--         "lua_ls",
--         "graphql",
--         "emmet_ls",
--         "prismals",
--         "pyright",
--       },
--       -- auto-install configured servers (with lspconfig)
--       automatic_installation = true, -- not the same as ensure_installed
--     }
--
--     mason_tool_installer.setup {
--       ensure_installed = {
--         "prettier", -- prettier formatter
--         "stylua", -- lua formatter
--         "isort", -- python formatter
--         "black", -- python formatter
--         "pylint", -- python linter
--         "eslint_d", -- js linter
--       },
--     }
--   end,
-- }

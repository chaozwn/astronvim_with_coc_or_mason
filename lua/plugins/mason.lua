return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.registries = require("astrocore").list_insert_unique(
        opts.registries,
        { "lua:custom-registry", "github:mason-org/mason-registry" }
      )
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    dependencies = { "williamboman/mason.nvim" },
    init = function(plugin) require("astrocore").on_load("mason.nvim", plugin.name) end,
    opts = {
      ensure_installed = {
        { "pylance", version = "2023.12.101" }, -- last known working version
      },
    },
    config = function(_, opts)
      local mason_tool_installer = require "mason-tool-installer"
      mason_tool_installer.setup(opts)
      mason_tool_installer.run_on_start()
    end,
  },
  { "jay-babu/mason-nvim-dap.nvim", optional = true, init = false },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = function(_, opts)
      require("astrocore").list_insert_unique(opts.ensure_installed, { "cssmodules_ls", "emmet_language_server" })
      require("utils").list_remove_unique(opts.ensure_installed, "emmet_ls")
    end,
  },
  { "jay-babu/mason-null-ls.nvim" },
}

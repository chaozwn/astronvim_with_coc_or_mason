return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.registries = require("astrocore").list_insert_unique(opts.registries, {
        "lua:custom-registry",
        "github:mason-org/mason-registry",
      })
    end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsUpdate", "MasonToolsClean" },
    dependencies = { "williamboman/mason.nvim" },
    init = function(plugin) require("astrocore").on_load("mason.nvim", plugin.name) end,
    opts = {
      ensure_installed = {
        { "pylance", version = "2024.3.2" }, -- last known working version
      },
    },
    config = function(_, opts)
      local mason_tool_installer = require "mason-tool-installer"
      mason_tool_installer.setup(opts)
      mason_tool_installer.run_on_start()
    end,
  },
  { "williamboman/mason-lspconfig.nvim", opts = {} },
  { "jay-babu/mason-null-ls.nvim", optional = true, opts = {} },
  { "nvimtools/none-ls.nvim", optional = true, opts = {} },
}

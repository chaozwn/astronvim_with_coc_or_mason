if true then return {} end

return {
  {
    "AstroNvim/astrolsp",
    opts = function(_, opts)
      local volar = require("mason-registry").get_package "vue-language-server"
      local vue_ts_plugin_path = volar:get_install_path()
        .. "/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"
      local vue_plugin = {
        name = "@vue/typescript-plugin",
        location = vue_ts_plugin_path,
        languages = { "vue" },
      }
      return require("astrocore").extend_tbl(opts, {
        config = {
          tsserver = {
            capabilities = {
              workspace = {
                didChangeWatchedFiles = { dynamicRegistration = true },
              },
            },
            filetypes = {
              "javascript",
              "javascriptreact",
              "javascript.jsx",
              "typescript",
              "typescriptreact",
              "typescript.tsx",
              "vue",
            },
            init_options = {
              plugins = {
                vue_plugin,
              },
            },
          },
        },
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = function(_, opts)
      if opts.ensure_installed ~= "all" then
        opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "vue" })
      end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "volar" })
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    optional = true,
    opts = function(_, opts)
      opts.ensure_installed = require("astrocore").list_insert_unique(opts.ensure_installed, { "js" })
    end,
  },
}

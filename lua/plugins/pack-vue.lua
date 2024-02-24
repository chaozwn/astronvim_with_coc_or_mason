local is_vue_project = require("utils").is_vue_project()
--TODO: after yarn, diagnostic not refresh
return {
  {
    ---@type LazySpec
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    ---@diagnostic disable: missing-fields
    opts = function(_, opts)
      local volar_handler = opts.handlers.volar
      if not is_vue_project then volar_handler = false end
      return require("astrocore").extend_tbl(opts, {
        handlers = {
          volar = volar_handler,
        },
        config = {
          volar = {
            capabilities = {
              workspace = {
                didChangeWatchedFiles = { dynamicRegistration = true },
              },
            },
            init_options = {
              languageFeatures = {
                implementation = true, -- new in @volar/vue-language-server v0.33
                references = true,
                definition = true,
                typeDefinition = true,
                callHierarchy = true,
                hover = true,
                rename = true,
                renameFileRefactoring = true,
                signatureHelp = true,
                codeAction = true,
                workspaceSymbol = true,
                completion = {
                  defaultTagNameCase = "both",
                  defaultAttrNameCase = "kebabCase",
                  getDocumentNameCasesRequest = true,
                  getDocumentSelectionRequest = true,
                },
                -- doc
                documentHighlight = true,
                documentLink = true,
                codeLens = { showReferencesNotification = true },
                -- not supported - https://github.com/neovim/neovim/pull/15723
                semanticTokens = true,
                diagnostics = true,
                schemaRequestService = true,
              },
              -- html
              documentFeatures = {
                selectionRange = true,
                foldingRange = true,
                linkedEditingRange = true,
                documentSymbol = true,
                -- not supported - https://github.com/neovim/neovim/pull/13654
                documentColor = true,
                documentFormatting = {
                  defaultPrintWidth = 100,
                },
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

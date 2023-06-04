-- TODO: add codeium
return {
  heirline = {
    separators = {
      breadcrumbs = "  ",
      path = "  ",
    },
  },
  diagnostics = {
    update_in_insert = false,
  },
  lazy = {
    defaults = { lazy = true },
    performance = {
      rtp = {
        -- customize default disabled vim plugins
        disabled_plugins = { "tohtml", "gzip", "matchit", "zipPlugin", "netrwPlugin", "tarPlugin" },
      },
    },
  },
  lsp = {
    -- enable servers that you already have installed without mason
    servers = {
      "pyright",
    },
    capabilities = {
      workspace = {
        applyEdit = true,
        workspaceEdit = {
          documentChanges = true,
          resourceOperations = {
            "create",
            "rename",
            "delete",
          },
          failureHandling = "textOnlyTransactional",
        },
        didChangeConfiguration = {
          dynamicRegistration = true,
        },
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = true,
          },
        },
      },
    },
  },
}

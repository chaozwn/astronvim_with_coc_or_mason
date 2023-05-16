local lspconfig_util = require "lspconfig.util"

-- brew install watchman
return {
  filetypes = {
    "typescript",
    "javascript",
    "javascriptreact",
    "typescriptreact",
    "vue",
    "json",
    "javascript.jsx",
    "typescript.tsx",
  },
  settings = {
    volar = {
      codeLens = {
        references = true,
        pugTools = true,
        scriptSetupTools = true,
      },
      vueserver = { fullCompletionList = true },
    },
    javascript = {
      updateImportsOnFileMove = {
        enabled = "always",
      },
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    typescript = {
      updateImportsOnFileMove = {
        enabled = "always",
      },
      preferences = {
        importModuleSpecifier = "non-relative",
      },
      inlayHints = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayVariableTypeHints = true,
      },
    },
    vue = {
      autoInsert = {
        dotValue = true,
      },
      updateImportsOnFileMove = {
        enabled = true,
      },
      server = {
        petiteVue = {
          supportHtmlFile = true,
        },
        fullCompletionList = true,
      },
      inlayHints = {
        inlineHandlerLeading = true,
        missingProp = true,
      },
      codeLens = {
        references = true,
        pugTools = true,
        scriptSetupTools = true,
      },
      useWorkspaceDependencies = true,
    },
  },
  init_options = {
    typescript = {
      tsdk = lspconfig_util.path.join(vim.fn.getcwd(), "node_modules", "typescript", "lib"),
    },
    languageFeatures = {
      references = true,
      definition = true,
      typeDefinition = true,
      callHierarchy = true,
      hover = false,
      rename = true,
      signatureHelp = true,
      codeAction = true,
      completion = {
        defaultTagNameCase = "both",
        defaultAttrNameCase = "kebabCase",
      },
      schemaRequestService = true,
      documentHighlight = true,
      codeLens = true,
      semanticTokens = true,
      diagnostics = true,
    },
    documentFeatures = {
      selectionRange = true,
      foldingRange = true,
      linkedEditingRange = true,
      documentSymbol = true,
      documentColor = true,
    },
  },
}

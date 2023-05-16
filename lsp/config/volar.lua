local lspconfig_util = require "lspconfig.util"

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
      tsdk = {
        tsdk = lspconfig_util.path.join(vim.fn.getcwd(), "node_modules", "typescript", "lib", "tsserverlibrary.js"),
      },
      updateImportsOnFileMove = {
        enabled = "always",
      },
      preferences = {
        importModuleSpecifier = "non-relative"
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
    },
  },
}

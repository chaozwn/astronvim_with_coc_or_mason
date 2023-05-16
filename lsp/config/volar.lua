return {
  filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
  settings = {
    vue = {
      autoInsert = {
        dotValue = true,
      },
      updateImportsOnFileMove = true,
      server = {
        petiteVue = {
          supportHtmlFile = true,
        },
      },
      inlayHints = {
        inlineHandlerLeading = true,
        missingProp = true,
      },
    },
  },
}

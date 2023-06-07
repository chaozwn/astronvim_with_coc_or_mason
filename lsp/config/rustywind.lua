local lsp_util = require "lspconfig.util"
return {
  root_dir = function(fname)
    return lsp_util.root_pattern("tailwind.config.cjs", "tailwind.config.ts", "tailwind.config.cjs")(fname)
  end,
  filetypes = { "astro" },
  settings = {
    tailwindCSS = {
      classAttributes = { "class", "className", "classList", "ngClass" },
      lint = {
        cssConflict = "warning",
        invalidApply = "error",
        invalidConfigPath = "error",
        invalidScreen = "error",
        invalidTailwindDirective = "error",
        invalidVariant = "error",
        recommendedVariantOrder = "warning",
      },
      validate = true,
    },
  },
}
